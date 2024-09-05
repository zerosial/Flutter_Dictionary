import 'package:flutter/material.dart';
import 'package:flutterzero/scheme/color_scheme.dart';
import 'package:flutterzero/screens/home_screen.dart';
import 'package:flutterzero/screens/pomodoro_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: colorScheme,
      ),
      home: const PomodoroScreen(),
    );
  }
}
