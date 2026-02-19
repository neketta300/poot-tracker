import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Nunito',
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.teal,
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
        seedColor: Colors.teal,
        brightness: Brightness.dark,
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