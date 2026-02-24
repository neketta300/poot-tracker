import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:poot_tracker/router/routes.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [
              SizedBox(height: 110.h),
              SvgPicture.asset(
                'assets/images/vectors/app/auth-logo.svg',
                width: 150,
              ),
              SizedBox(height: 60.h),
              Text(
                textAlign: TextAlign.center,
                'Приложение Poot – это новый\nуровень заботы о животике.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 90.h),
              AuthButton(
                text: 'Продолжить с Apple',
                onTap: () {},
                buttonColor: Colors.black,
                textColor: Colors.white,
                icon: Icons.apple,
                iconColor: Colors.white,
              ),
              SizedBox(height: 12.h),
              AuthButton(
                text: 'Продолжить с Google',
                pathToSvgIcon: 'assets/images/vectors/auth/google.svg',
                onTap: () {},
                buttonColor: Color(0xfff2f2f2),
                textColor: Colors.black,
              ),
              SizedBox(height: 12.h),
              AuthButton(
                text: 'Продолжить с эл. почтой',
                onTap: () {},
                buttonColor: Color(0xfff2f2f2),
                textColor: Colors.black,
                icon: Icons.mail,
                iconColor: Colors.black,
              ),
              SizedBox(height: 10.h),
              AuthButton(
                text: 'Пропустить',
                onTap: () {
                  context.go(AppRoutes.dashboard);
                },
                buttonColor: Colors.transparent,
                textColor: Color(0xff666666),
                iconColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final Color? iconColor;
  final IconData? icon;
  final String text;
  final String? pathToSvgIcon;
  final void Function()? onTap;
  const AuthButton({
    super.key,
    this.onTap,
    required this.buttonColor,
    required this.textColor,
    this.icon,
    this.pathToSvgIcon,
    this.iconColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(icon, color: iconColor, size: 32)
              else if (pathToSvgIcon != null && pathToSvgIcon!.isNotEmpty)
                SvgPicture.asset(
                  pathToSvgIcon!,
                  height: 24,
                  // colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                )
              else
                const SizedBox.shrink(), // Если иконок нет вообще
              SizedBox(width: 8.w),
              Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
