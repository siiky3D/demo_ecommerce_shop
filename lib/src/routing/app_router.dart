import 'package:demo_app/src/features/authentication/presentation/account/account_screen.dart';
import 'package:demo_app/src/features/cart/presentation/shopping_cart/shopping_cart_screen.dart';
import 'package:demo_app/src/features/checkout/presentation/checkout_screen/checkout_screen.dart';
import 'package:demo_app/src/features/onboarding/data/onboarding_repository.dart';
import 'package:demo_app/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:demo_app/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:demo_app/src/features/authentication/presentation/sign_in/email_password_sign_in_form_type.dart';
import 'package:demo_app/src/features/authentication/presentation/reset_password/reset_password_screen.dart';
import 'package:demo_app/src/features/authentication/presentation/sign_in/sign_in_screen.dart';
import 'package:demo_app/src/features/orders/presentation/orders_list/orders_list_screen.dart';
import 'package:demo_app/src/features/products/presentation/product_screen/product_screen.dart';
import 'package:demo_app/src/features/products/presentation/products_list/products_list_screen.dart';
import 'package:demo_app/src/features/products_admin/presentation/admin_product_edit_screen.dart';
import 'package:demo_app/src/features/products_admin/presentation/admin_product_upload_screen.dart';
import 'package:demo_app/src/features/products_admin/presentation/admin_products_add_screen.dart';
import 'package:demo_app/src/features/products_admin/presentation/admin_products_screen.dart';
import 'package:demo_app/src/features/reviews/presentation/leave_review_screen/leave_review_screen.dart';
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
  checkout,
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
        if (path != 'onboarding') {
          return '/onboarding';
        }
        return null;
      }
      if (!isLoggedIn) {
        if (path == '/account' || path == '/orders' || path == '/checkout' || path == '/') {
          return '/signIn';
        }
        if (path.startsWith('/admin')) {
          return '/signIn';
        }
      } else {
        if (path == '/signIn') {
          return '/';
        }
        final isAdmin = await user.isAdmin();
        if (!isAdmin && path.startsWith('/admin')) {
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
        builder: (context, state) => const ProductsListScreen(),
        routes: [
          GoRoute(
            path: 'product/:id',
            name: AppRoute.product.name,
            builder: (context, state) {
              final productId = state.pathParameters['id']!;
              return ProductScreen(productId: productId);
            },
            routes: [
              GoRoute(
                path: 'review',
                name: AppRoute.leaveReview.name,
                pageBuilder: (context, state) {
                  final productId = state.pathParameters['id']!;
                  return MaterialPage(
                    fullscreenDialog: true,
                    child: LeaveReviewScreen(productId: productId),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: 'cart',
            name: AppRoute.cart.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: ShoppingCartScreen(),
            ),
            routes: [
              GoRoute(
                path: 'checkout',
                name: AppRoute.checkout.name,
                pageBuilder: (context, state) => const MaterialPage(
                  fullscreenDialog: true,
                  child: CheckoutScreen(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: 'orders',
            name: AppRoute.orders.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: OrdersListScreen(),
            ),
          ),
          GoRoute(
            path: 'account',
            name: AppRoute.account.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: AccountScreen(),
            ),
          ),
          GoRoute(
            path: 'signIn',
            name: AppRoute.signIn.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: SignInScreen(formType: EmailPasswordSignInFormType.signIn),
            ),
          ),
          GoRoute(
            path: 'admin',
            name: AppRoute.admin.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: AdminProductsScreen(),
            ),
            routes: [
              GoRoute(
                path: 'add',
                name: AppRoute.adminAdd.name,
                pageBuilder: (context, state) => const MaterialPage(
                  fullscreenDialog: true,
                  child: AdminProductsAddScreen(),
                ),
                routes: [
                  GoRoute(
                    path: ':id',
                    name: AppRoute.adminUploadProduct.name,
                    builder: (context, state) {
                      final productId = state.pathParameters['id']!;
                      return AdminProductUploadScreen(productId: productId);
                    },
                  ),
                ],
              ),
              GoRoute(
                path: 'edit/:id',
                name: AppRoute.adminEditProduct.name,
                pageBuilder: (context, state) {
                  final productId = state.pathParameters['id']!;
                  return MaterialPage(
                    fullscreenDialog: true,
                    child: AdminProductEditScreen(productId: productId),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/onboarding',
        name: AppRoute.onboarding.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: '/resetPassword',
        name: AppRoute.resetPassword.name,
        pageBuilder: (context, state) => CustomTransitionPage(
          fullscreenDialog: true,
          child: ResetPasswordScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOut));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      ),
    ],
    errorPageBuilder: (context, state) => const MaterialPage(
      fullscreenDialog: true,
      child: NotFoundScreen(),
    ),
  );
}
