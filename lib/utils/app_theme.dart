import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF2D3142);
  static const Color secondaryColor = Color(0xFF4F5D75);
  static const Color tertiaryColor = Color(0xFFBFC0C0);
  static const Color backgroundColor = Color(0xFFEF8354);
  static const Color surfaceColor = Colors.white;
  static const Color onPrimaryColor = Colors.white;
  static const Color onSecondaryColor = Colors.white;
  static const Color onTertiaryColor = Colors.black;
  static const Color onBackgroundColor = Colors.white;
  static const Color onSurfaceColor = Colors.black;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: tertiaryColor,
        background: backgroundColor,
        surface: surfaceColor,
        onPrimary: onPrimaryColor,
        onSecondary: onSecondaryColor,
        onTertiary: onTertiaryColor,
        onBackground: onBackgroundColor,
        onSurface: onSurfaceColor,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
        titleMedium: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: primaryColor,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 16,
          color: primaryColor,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 14,
          color: secondaryColor,
        ),
        labelLarge: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: onPrimaryColor,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: surfaceColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: primaryColor,
          foregroundColor: onPrimaryColor,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: tertiaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor),
        ),
        filled: true,
        fillColor: surfaceColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: onPrimaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: tertiaryColor,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      iconTheme: const IconThemeData(
        color: primaryColor,
        size: 24,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: onPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: tertiaryColor,
        background: const Color(0xFF121212),
        surface: const Color(0xFF1E1E1E),
        onPrimary: onPrimaryColor,
        onSecondary: onSecondaryColor,
        onTertiary: onTertiaryColor,
        onBackground: onPrimaryColor,
        onSurface: onPrimaryColor,
      ),
      // Dark theme specific styles can be added here
    );
  }
} 