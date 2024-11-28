abstract class MainStates {}

class MainInitialState extends MainStates {}

class MainGetUserSuccessState extends MainStates {}

class MainGetUserErrorState extends MainStates {
  final String error;

  MainGetUserErrorState(this.error);
}

class MainLoginSuccessState extends MainStates {
  final String uId;

  MainLoginSuccessState(this.uId);
}

class MainLoginErrorState extends MainStates {
  final String error;

  MainLoginErrorState(this.error);
}

class MainCreateUserSuccessState extends MainStates {}

class MainCreateUserErrorState extends MainStates {
  final String error;

  MainCreateUserErrorState(this.error);
}

class MainCreateNewTaskSuccessState extends MainStates {}

class MainCreateNewTaskErrorState extends MainStates {
  final String error;

  MainCreateNewTaskErrorState(this.error);
}

class MainGetTasksSuccessState extends MainStates {}

class MainGetTasksErrorState extends MainStates {
  final String error;

  MainGetTasksErrorState(this.error);
}
