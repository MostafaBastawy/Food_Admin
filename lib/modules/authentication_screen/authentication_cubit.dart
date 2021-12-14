import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin_interface/modules/authentication_screen/authentication_states.dart';

class AppAuthenticationCubit extends Cubit<AppAuthenticationStates> {
  AppAuthenticationCubit() : super(AppAuthenticationInitialState());
  static AppAuthenticationCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(AppAuthenticationLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(AppAuthenticationLoginSuccessState());
    }).catchError((error) {
      emit(AppAuthenticationLoginErrorState(error.toString()));
    });
  }

  void userSignOut() {
    emit(AppAuthenticationLoadingState());
    FirebaseAuth.instance.signOut().then((value) {
      emit(AppAuthenticationSignOutSuccessState());
    }).catchError((error) {
      emit(AppAuthenticationSignOutErrorState(error.toString()));
    });
  }
}
