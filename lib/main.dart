import 'package:flutter/material.dart';
import './screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF4CAF50), // Green
        scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Light Grey
        cardColor: const Color(0xFFFFFFFF), // White
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF4CAF50), // Green
          secondary: Color(0xFF8BC34A), // Light Green Accent
          surface: Color(0xFFFFFFFF), // White
          background: Color(0xFFF5F5F5), // Light Grey
          error: Colors.redAccent,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Color(0xFF333333), // Dark Grey
          onBackground: Color(0xFF333333), // Dark Grey
          onError: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4CAF50), // Green
          elevation: 4,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4CAF50), // Green
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF4CAF50), // Green
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}