// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // Import the login screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskMate',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(), // Set the login screen as the home
    );
  }
}