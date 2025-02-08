import 'package:demo_app/src/features/onboarding/data/onboarding_repository.dart';
import 'package:demo_app/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:demo_app/src/features/user_authentication/data/firebase_auth_repository.dart';
import 'package:demo_app/src/features/user_authentication/presentation/sign_in_screen.dart';
import 'package:demo_app/src/routing/go_router_refresh_stream.dart';
import 'package:demo_app/src/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  onboarding,
  signIn,
  productListing,
  searchFunctionality,
  shoppingCart,
  checkoutAndPayment,
  productReviewsAndRatings,
  promotionsAndDiscounts,
  userAuthentication,
  orderTracking,
  profileManagement,
  pushNotifications,
  adminPanel,
  socialSharing,
  wishlist,
  shippingAndDeliveryOptions,
  orderHistory
}

@riverpod
GoRouter goRouter(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/signin',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final onboardingAsync = ref.watch(onboardingRepositoryProvider);
      if (onboardingAsync.isLoading) return null;

      final onboardingRepository = onboardingAsync.requireValue;
      final didCompleteOnboarding = onboardingRepository.isOnboardingComplete();
      final path = state.uri.path;

      if (!didCompleteOnboarding) {
        if (path != '/onboarding') {
          return '/onboarding';
        }
        return null;
      }
      final isLoggedIn = authRepository.currentUser != null;

      if (isLoggedIn) {
        if (path.startsWith('/onboarding') || path.startsWith('/signIn')) {
          return '/jobs';
        }
      } else {
        final protectedRoutes = [
          '/onboarding',
          '/productListing',
          '/searchFunctionality',
          '/shoppingCart',
          '/checkoutAndPayment',
          '/productReviewsAndRatings',
          '/promotionsAndDiscounts',
          '/userAuthentication',
          '/orderTracking',
          '/profileManagement',
          '/pushNotifications',
          '/adminPanel',
          '/socialSharing',
          '/wishlist',
          '/shippingAndDeliveryOptions',
          '/orderHistory',
        ];
        if (protectedRoutes.any(path.startsWith)) {
          return '/signIn';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/onboarding',
        name: AppRoute.onboarding.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SignInScreen(),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => const NoTransitionPage(
      child: NotFoundScreen(),
    ),
  );
}
