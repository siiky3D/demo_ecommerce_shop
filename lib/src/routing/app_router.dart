import 'package:demo_ecommerce_shop/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:demo_ecommerce_shop/src/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  onboarding,
  productListing,
  searchFunctionality,
  shoppingCart,
  checkoutAndPayment,
  productReviewsAndRatings,
  promotionsAndDiscounts,
  userAuthentication,
  orderTracking,
  userProfileManagement,
  pushNotifications,
  adminPanel,
  socialSharing,
  wishlist,
  shippingAndDeliveryOptions,
  orderHistory
}

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/onboarding',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
        name: AppRoute.onboarding.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: OnboardingScreen(),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => const NoTransitionPage(
      child: NotFoundScreen(),
    ),
  );
}
