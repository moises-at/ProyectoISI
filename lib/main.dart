import 'package:flutter/material.dart';
import 'package:pastiya/screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App de Medicamentos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(email: 'fjdfks',),
      );
    }
  }
    