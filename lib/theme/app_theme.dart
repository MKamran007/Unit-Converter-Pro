import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light Theme Colors
  static const Color lightPrimary = Color(0xFF2196F3);
  static const Color lightSecondary = Color(0xFF03A9F4);
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF5F5F5);
  static const Color lightText = Color(0xFF212121);
  static const Color lightTextSecondary = Color(0xFF757575);

  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFF42A5F5);
  static const Color darkSecondary = Color(0xFF29B6F6);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightBackground,

    colorScheme: const ColorScheme.light(
      primary: lightPrimary,
      secondary: lightSecondary,
      surface: lightSurface,
      background: lightBackground,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: lightText,
      onBackground: lightText,
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: lightPrimary,
      foregroundColor: Colors.white,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightSurface,
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
        borderSide: const BorderSide(color: lightPrimary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: lightText,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: lightText,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: lightText,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: lightText,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: lightText,
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: 16,
        color: lightText,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 14,
        color: lightTextSecondary,
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightPrimary,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(
      color: lightText,
      size: 24,
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBackground,

    colorScheme: const ColorScheme.dark(
      primary: darkPrimary,
      secondary: darkSecondary,
      surface: darkSurface,
      background: darkBackground,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: darkText,
      onBackground: darkText,
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: darkSurface,
      foregroundColor: darkText,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: darkText,
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: darkSurface,
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkSurface,
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
        borderSide: const BorderSide(color: darkPrimary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: darkText,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: darkText,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: darkText,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: darkText,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: darkText,
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: 16,
        color: darkText,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 14,
        color: darkTextSecondary,
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkPrimary,
        foregroundColor: Colors.black,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(
      color: darkText,
      size: 24,
    ),
  );
}