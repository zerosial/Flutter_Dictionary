// 뽀모도로 앱 화면
import 'package:flutter/material.dart';

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Pomodoro App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: const Color(0xFF1F1F1F),
      body: const Center(
        child: Text(
          'Pomodoro App Content',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
