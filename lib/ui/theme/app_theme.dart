import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Основной цвет
const primaryColor = Color(0xFF9270BC);

class AppTheme {
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      surface: Colors.white,
      brightness: Brightness.light,
    );
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Nunito',
      colorScheme: colorScheme,
      scaffoldBackgroundColor: Colors.white,

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontFamily: 'Nunito',
        ),
      ),

      bottomAppBarTheme: const BottomAppBarThemeData(
        elevation: 0,
        color: Colors.white,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
      ),

      bottomSheetTheme: BottomSheetThemeData(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        modalBackgroundColor: Colors.white,
        modalBarrierColor: Colors.black.withAlpha(100),
      ),

      // Текстовая тема
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        headlineMedium: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        bodyLarge: TextStyle(fontSize: 18.sp, color: colorScheme.onSurface),
        bodyMedium: TextStyle(fontSize: 16.sp, color: colorScheme.onSurface),
        labelLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      surface: Color(0xFF121212),
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Nunito',
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFF121212),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF121212),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
          color: Colors.white,
        ),
      ),

      // BottomAppBar
      bottomAppBarTheme: const BottomAppBarThemeData(
        color: Color(0xFF121212),
        surfaceTintColor: Colors.transparent,
      ),

      // FloatingActionButton
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
      ),

      // ModalBottomSheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: const Color(0xFF1E1E1E),
        modalBackgroundColor: const Color(0xFF1E1E1E),
        modalBarrierColor: Colors.black.withOpacity(0.7),
      ),

      // Текстовая тема
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        headlineMedium: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        bodyLarge: TextStyle(fontSize: 18.sp, color: colorScheme.onSurface),
        bodyMedium: TextStyle(fontSize: 16.sp, color: colorScheme.onSurface),
        labelLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }
}
