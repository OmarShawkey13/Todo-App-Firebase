import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/layout/cubit/cubit.dart';
import 'package:todo/layout/cubit/states.dart';
import 'package:todo/models/task_model.dart';

class MainActivity extends StatelessWidget {
  MainActivity({super.key});

  final addTaskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (BuildContext context, MainStates state) {},
      builder: (BuildContext context, MainStates state) {
        var cubit = MainCubit.get(context);
        var item = cubit.items;
        var model = cubit.userModel;
        return Scaffold(
          backgroundColor: const Color(0xFFFEF8F8),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: const Color(0xFF2EA8A1),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              AssetImage('assets/images/profile.jpg'),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Welcome ${model!.name}',
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'Good Afternoon',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const SizedBox(
                        height: 150.0,
                        width: 150.0,
                        child: AnalogClock(),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Tasks List',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 10.0,
                          color: const Color(0xFFFFFEFE),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Daily Tasks',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        alertAddNewTask(context);
                                      },
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemBuilder: (context, index) =>
                                        buildTaskItem(item[index]),
                                    itemCount: item.length,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future alertAddNewTask(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add New Task'),
            actions: <Widget>[
              TextFormField(
                controller: addTaskController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Task must be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Add Task',
                    label: const Text('Add Task'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextButton(
                child: const Text('Add'),
                onPressed: () {
                  MainCubit.get(context)
                      .upload(title: addTaskController.text);
                  addTaskController.clear();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

  Widget buildTaskItem(TaskModel model) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          model.title!,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
