import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/src/app_bootstrap.dart';
import 'package:demo_app/src/exceptions/async_error_logger.dart';
import 'package:demo_app/src/features/cart/data/local/local_cart_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/cart/data/local/sembast_cart_repository.dart';

/// Extension methods specific for the Firebase project configuration
extension AppBootstrapFirebase on AppBootstrap {
  /// Creates the top-level [ProviderContainer] by overriding providers with fake
  /// repositories only. This is useful for testing purposes and for running the
  /// app with a "fake" backend.
  ///
  /// Note: all repositories needed by the app can be accessed via providers.
  /// Some of these providers throw an [UnimplementedError] by default.
  ///
  /// Example:
  /// ```dart
  /// @Riverpod(keepAlive: true)
  /// LocalCartRepository localCartRepository(LocalCartRepositoryRef ref) {
  ///   throw UnimplementedError();
  /// }
  /// ```
  ///
  /// As a result, this method does two things:
  /// - create and configure the repositories as desired
  /// - override the default implementations with a list of "overrides"
  Future<ProviderContainer> createFirebaseProviderContainer({bool addDelay = true}) async {
    final localCartRepository = await SembastCartRepository.makeDefault();
    return ProviderContainer(
      overrides: [
        // repositories
        localCartRepositoryProvider.overrideWithValue(localCartRepository),
      ],
      observers: [AsyncErrorLogger()],
    );
  }

  Future<void> setupEmulators() async {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
    // * When running on the emulator, disable persistence to avoid discrepancies
    // * between the emulated database and local caches. More info here:
    // * https://firebase.google.com/docs/emulator-suite/connect_firestore#instrument_your_app_to_talk_to_the_emulators
    FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: false);
  }
}
