// lib/app/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poot_tracker/router/app_router.dart';
import 'package:poot_tracker/ui/theme/app_theme.dart';
import 'package:poot_tracker/features/onboarding/view/onboarding_screen.dart';

class PootApp extends StatelessWidget {
  const PootApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenUtilInit — точка входа для адаптивности
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Базовый размер макета (iPhone 13/14)
      minTextAdapt: true, // Масштабировать текст с учетом ширины
      splitScreenMode: true, // Поддержка split-screen на планшетах/Android

      child: const OnboardingScreen(),
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Poot',

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
