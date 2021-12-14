import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin_interface/cubit/bloc_observer.dart';
import 'package:food_admin_interface/cubit/cubit.dart';
import 'package:food_admin_interface/modules/authentication_screen/authentication_cubit.dart';
import 'package:food_admin_interface/modules/authentication_screen/authentication_screen.dart';
import 'package:food_admin_interface/modules/home_layout_screen.dart';
import 'package:food_admin_interface/shared/design/themes.dart';
import 'package:food_admin_interface/shared/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  String uid = CacheHelper.getData(key: 'uid') ?? '';
  Widget startScreen;
  uid.isNotEmpty
      ? startScreen = HomeLayoutScreen()
      : startScreen = AuthenticationScreen();
  runApp(
    MyApp(
      startScreen: startScreen,
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget? startScreen;
  const MyApp({Key? key, this.startScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => AppCubit()
              ..getAllPostOrders()
              ..getAllOngoingOrders()),
        BlocProvider(
            create: (BuildContext context) => AppAuthenticationCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: startScreen,
      ),
    );
  }
}
