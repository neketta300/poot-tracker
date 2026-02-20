import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const primaryColor = Color(0xFF9270BC);

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,

      fontFamily: 'Nunito',
      colorScheme: ColorScheme.fromSeed(
        primary: primaryColor,
        // seedColor: Colors.teal,
        seedColor: primaryColor,
        brightness: Brightness.light,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(fontSize: 18.sp),
        bodyMedium: TextStyle(fontSize: 16.sp),
        labelLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Nunito',
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: primaryColor,
        primary: primaryColor,
        // seedColor: Colors.teal,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(fontSize: 18.sp),
        bodyMedium: TextStyle(fontSize: 16.sp),
        labelLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
      ),
    );
  }
}
