import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData(
    primaryColor: const Color(0xFF1DB954), // Spotify Green
    scaffoldBackgroundColor: const Color(0xFFFFFFFF), // White
    cardColor: const Color(0xFFFFFFFF), // White for list item backgrounds
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF), // White
      foregroundColor: Color(0xFF191414), // Cod Gray for AppBar text/icons
      elevation: 0,
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1DB954), // Spotify Green
      secondary: Color(0xFFFFC107), // You can choose a secondary accent if needed
      error: Color(0xFFF44336),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF191414)), // Cod Gray
      bodyMedium: TextStyle(color: Color(0xFF191414)), // Cod Gray
      bodySmall: TextStyle(color: Color(0xFF757575)), // Gray (Secondary Text)
      headlineLarge: TextStyle(color: Color(0xFF191414), fontWeight: FontWeight.bold), // Cod Gray
      headlineMedium: TextStyle(color: Color(0xFF191414), fontWeight: FontWeight.bold), // Cod Gray
      headlineSmall: TextStyle(color: Color(0xFF191414), fontWeight: FontWeight.bold), // Cod Gray
      titleLarge: TextStyle(color: Color(0xFF191414), fontWeight: FontWeight.bold), // Cod Gray
      titleMedium: TextStyle(color: Color(0xFF191414), fontWeight: FontWeight.bold), // Cod Gray
      titleSmall: TextStyle(color: Color(0xFF191414), fontWeight: FontWeight.bold), // Cod Gray
      labelLarge: TextStyle(color: Color(0xFF191414), fontWeight: FontWeight.bold), // Cod Gray
      labelMedium: TextStyle(color: Color(0xFF191414), fontWeight: FontWeight.bold), // Cod Gray
      labelSmall: TextStyle(color: Color(0xFF757575)), // Gray (Secondary Text)
    ),
    iconTheme: const IconThemeData(color: Color(0xFF191414)), // Cod Gray
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1DB954), // Spotify Green
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF1DB954), // Spotify Green
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF1DB954))), // Spotify Green
      labelStyle: TextStyle(color: Color(0xFF757575)), // Gray (Secondary Text)
    ),
  );

  ThemeData get darkTheme => ThemeData(
    primaryColor: const Color(0xFF1DB954), // Spotify Green
    scaffoldBackgroundColor: const Color(0xFF191414), // Cod Gray
    cardColor: const Color(0xFF212121), // Charcoal for list item backgrounds
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF191414), // Cod Gray
      foregroundColor: Color(0xFFFFFFFF), // White for AppBar text/icons
      elevation: 0,
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF1DB954), // Spotify Green
      secondary: Color(0xFFB3B3B3), // Gray (Secondary Text) as a subtle accent
      error: Color(0xFFF44336),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFFFFFFF)), // White
      bodyMedium: TextStyle(color: Color(0xFFFFFFFF)), // White
      bodySmall: TextStyle(color: Color(0xFFB3B3B3)), // Gray (Secondary Text)
      headlineLarge: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold), // White
      headlineMedium: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold), // White
      headlineSmall: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold), // White
      titleLarge: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold), // White
      titleMedium: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold), // White
      titleSmall: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold), // White
      labelLarge: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold), // White
      labelMedium: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold), // White
      labelSmall: TextStyle(color: Color(0xFFB3B3B3)), // Gray (Secondary Text)
    ),
    iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)), // White
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1DB954), // Spotify Green
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF1DB954), // Spotify Green
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFB3B3B3))), // Gray
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF1DB954))), // Spotify Green
      labelStyle: TextStyle(color: Color(0xFFB3B3B3)), // Gray (Secondary Text)
    ),
  );
}