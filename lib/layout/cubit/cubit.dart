import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/layout/cubit/states.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/shared/components/constants.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitialState());

  static MainCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  List<UserModel> userItem = [];

  void getUserData() {
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      if (value.exists && value.data() != null) {
        userModel = UserModel.fromJson(value.data());
        emit(MainGetUserSuccessState());
      }
    }).catchError((error) {
      emit(MainGetUserErrorState(error.toString()));
    });
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(MainLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(MainLoginErrorState(error.toString()));
    });
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      UserModel userModel = UserModel(
        name: name,
        email: email,
        uId: value.user!.uid,
      );

      FirebaseFirestore.instance
          .collection('users')
          .doc(value.user!.uid)
          .set(userModel.toMap())
          .then((value) {
        emit(MainCreateUserSuccessState());
      }).catchError((error) {
        emit(MainCreateUserErrorState(error.toString()));
      });
    });
  }

  TaskModel? taskModel;

  void upload({
    required String title,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('task')
        .orderBy('id', descending: true)
        .limit(1)
        .get()
        .then((value) {
      int newId = 1;
      if (value.docs.isNotEmpty) {
        newId = value.docs.first['id'] + 1;
      }
      addNewTask(
        title: title,
        id: newId,
      );
      getData();
      emit(MainCreateNewTaskSuccessState());
    }).catchError((error) {
      emit(MainCreateNewTaskErrorState(error.toString()));
    });
  }

  void addNewTask({required String title, required int id}) {
    TaskModel taskModel = TaskModel(
      id: id,
      title: title,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('task')
        .add(taskModel.toMap())
        .then((value) {
      emit(MainCreateNewTaskSuccessState());
    }).catchError((error) {
      emit(MainCreateNewTaskErrorState(error.toString()));
    });
  }

  List<TaskModel> items = [];

  void getData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('task')
        .orderBy('id', descending: true)
        .get()
        .then((value) {
      items = [];
      for (var element in value.docs) {
        items.add(TaskModel.fromJson(element.data()));
      }
      emit(MainGetTasksSuccessState());
    }).catchError((error) {
      emit(MainGetTasksErrorState(error.toString()));
    });
  }
}
