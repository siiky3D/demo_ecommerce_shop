import 'package:demo_app/src/features/onboarding/data/onboarding_repository.dart';
import 'package:demo_app/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:demo_app/src/features/products/presentation/produc_listing_screen.dart';
import 'package:demo_app/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:demo_app/src/features/authentication/presentation/email_password_sign_in_form_type.dart';
import 'package:demo_app/src/features/authentication/presentation/reset_password_screen.dart';
import 'package:demo_app/src/features/authentication/presentation/sign_in_screen.dart';
import 'package:demo_app/src/features/authentication/presentation/sign_up_screen.dart';
import 'package:demo_app/src/routing/go_router_refresh_stream.dart';
import 'package:demo_app/src/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  admin,
  adminAdd,
  adminEditProduct,
  adminUploadProduct,
  account,
  cart,
  checkoutAndPayment,
  home,
  leaveReview,
  onboarding,
  orders,
  orderHistory,
  orderTracking,
  product,
  productReviewsAndRatings,
  profileManagement,
  promotionsAndDiscounts,
  pushNotifications,
  resetPassword,
  searchFunctionality,
  shippingAndDeliveryOptions,
  signIn,
  signUp,
  socialSharing,
  userAuthentication,
  wishlist,
}

@riverpod
GoRouter goRouter(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      final user = authRepository.currentUser;
      final isLoggedIn = user != null;
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

      if (isLoggedIn) {
        // if (path.startsWith('/onboarding') || path.startsWith('/signIn')) {
        if (path == '/signIn') {
          return '/';
        }
        final isAdmin = await user.isAdmin();
        if (!isAdmin && path.startsWith('/admin')) {
          return '/';
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
          return '/';
        }
        if (path.startsWith('/admin')) {
          return '/';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const ProductListingScreen(),
        routes: [],
      ),
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
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: SignInScreen(formType: EmailPasswordSignInFormType.signIn),
        ),
      ),
      GoRoute(
        path: '/signUp',
        name: AppRoute.signUp.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SignUpScreen(),
        ),
      ),
      GoRoute(
        path: '/resetPassword',
        name: AppRoute.resetPassword.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: ResetPasswordScreen(),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => const NoTransitionPage(
      child: NotFoundScreen(),
    ),
  );
}
