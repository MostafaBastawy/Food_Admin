import 'package:flutter/material.dart';
import 'package:food_admin_interface/modules/home_layout_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      darkTheme: ThemeData(),
      themeMode: ThemeMode.light,
      home: const HomeLayoutScreen(),
    );
  }
}

