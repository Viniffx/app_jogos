import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF7C4DFF);
  static const Color secondary = Color(0xFF536DFE);
  static const Color background = Color(0xFF0F0F17);
  static const Color card = Color(0xFF191923);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,

    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: secondary,
      surface: card,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: card,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: primary,
          width: 2,
        ),
      ),

      labelStyle: const TextStyle(
        color: Colors.white70,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}