import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin_interface/modules/authentication_screen/authentication_cubit.dart';
import 'package:food_admin_interface/modules/authentication_screen/authentication_states.dart';
import 'package:food_admin_interface/modules/home_layout_screen.dart';
import 'package:food_admin_interface/shared/components/authentication_login.dart';
import 'package:food_admin_interface/shared/components/default_button.dart';
import 'package:food_admin_interface/shared/components/navigator.dart';
import 'package:food_admin_interface/shared/components/show_toaster.dart';
import 'package:food_admin_interface/shared/design/colors.dart';
import 'package:food_admin_interface/shared/shared_preferences.dart';

class AuthenticationScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppAuthenticationCubit cubit = AppAuthenticationCubit.get(context);
    return BlocConsumer<AppAuthenticationCubit, AppAuthenticationStates>(
      listener: (BuildContext context, state) {
        if (state is AppAuthenticationLoginSuccessState) {
          defaultToast(
            message: 'Login successfully',
            color: Colors.green,
            context: context,
          );
          CacheHelper.setData(
              key: 'uid', value: FirebaseAuth.instance.currentUser!.uid);
          navigateAndFinish(context: context, widget: HomeLayoutScreen());
        }
        if (state is AppAuthenticationLoginErrorState) {
          defaultToast(
            message: state.error.substring(30),
            color: Colors.red,
            context: context,
          );
        }
      },
      builder: (BuildContext context, Object? state) => Scaffold(
        appBar: null,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/background_Image.jpg',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            bottom: 30.0, top: 40.0),
                        child: Container(
                          padding: const EdgeInsets.all(25.0),
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.white,
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/cutlery_logo.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Admin Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: defaultColor,
                            ),
                          ),
                        ),
                      ),
                      LoginAuthentication(
                        emailController: emailController,
                        passwordController: passwordController,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! AppAuthenticationLoadingState,
                        builder: (BuildContext context) => DefaultButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                            }
                          },
                          labelText: 'Login',
                          color: defaultColor,
                        ),
                        fallback: (BuildContext context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
