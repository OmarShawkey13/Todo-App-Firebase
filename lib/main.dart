import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/layout/cubit/cubit.dart';
import 'package:todo/layout/cubit/states.dart';
import 'package:todo/layout/main_activity.dart';
import 'package:todo/modules/onboarding/onboarding_screen.dart';
import 'package:todo/shared/components/constants.dart';
import 'package:todo/shared/network/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  Widget startWidget;
  if (uId != null) {
    startWidget = MainActivity();
  } else {
    startWidget = const OnboardingScreen();
  }
  runApp(MyApp(
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  const MyApp({
    super.key,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MainCubit()
        ..getUserData()
        ..getData(),
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (BuildContext context, MainStates state) {},
        builder: (BuildContext context, MainStates state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
