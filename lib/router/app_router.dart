import 'package:go_router/go_router.dart';
import 'package:poot_tracker/features/auth/view/auth_screen.dart';
import 'package:poot_tracker/features/consent/view/consent_screen.dart';
import 'package:poot_tracker/features/onboarding/view/onboarding_screen.dart';
import 'package:poot_tracker/router/router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.onboarding,
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.consent,
        builder: (context, state) => const ConsentScreen(),
      ),
      GoRoute(
        path: AppRoutes.auth,
        builder: (context, state) => const AuthScreen(),
      ),
    ],
  );
}
