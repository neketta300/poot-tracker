import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../router/router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _showHello = false;
  bool _showTitle = false;
  bool _showDescription = false;

  @override
  void initState() {
    super.initState();
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() => _showHello = true);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _showHello = false;
      _showTitle = true;
    });
    await Future.delayed(Duration(milliseconds: 800));
    setState(() => _showDescription = true);

    // Автоматический переход на ConsentScreen после появления описания
    await Future.delayed(Duration(milliseconds: 1500));
    if (mounted) {
      context.go(AppRoutes.consent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Spacer(flex: 6),
              SizedBox(
                height: 70.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedOpacity(
                      opacity: _showHello ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 500),
                      child: Text(
                        'Привет',
                        style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: _showTitle ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 500),
                      child: Text(
                        'Я Poot',
                        style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedOpacity(
                opacity: _showDescription ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),
                child: Text(
                  'Твой личный трекер здоовья желудка',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 500),
                  ),
                ),
              ),
              Spacer(flex: 7),
            ],
          ),
        ),
      ),
    );
  }
}
