abstract class AppAuthenticationStates {}

class AppAuthenticationInitialState extends AppAuthenticationStates {}

class AppAuthenticationLoadingState extends AppAuthenticationStates {}

class AppAuthenticationLoginSuccessState extends AppAuthenticationStates {}

class AppAuthenticationLoginErrorState extends AppAuthenticationStates {
  String error;
  AppAuthenticationLoginErrorState(this.error);
}

class AppAuthenticationSignOutSuccessState extends AppAuthenticationStates {}

class AppAuthenticationSignOutErrorState extends AppAuthenticationStates {
  String error;
  AppAuthenticationSignOutErrorState(this.error);
}