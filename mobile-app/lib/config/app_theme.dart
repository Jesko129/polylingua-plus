import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryDark = Color(0xFF0f3460);
  static const Color secondaryDark = Color(0xFF16213e);
  static const Color accentCyan = Color(0xFF00d4ff);
  static const Color textWhite = Color(0xFFffffff);
  static const Color textGray = Color(0xFF888888);
  static const Color errorRed = Color(0xFFff6b6b);

  // Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: accentCyan,
      scaffoldBackgroundColor: primaryDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: secondaryDark,
        foregroundColor: textWhite,
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: secondaryDark,
        selectedItemColor: accentCyan,
        unselectedItemColor: textGray,
        elevation: 8,
      ),
    );
  }
}