import 'dart:async';

import 'package:demo_app/src/features/checkout/application/checkout_service.dart';
import 'package:demo_app/src/utils/notifier_mounted.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payment_button_controller.g.dart';

@riverpod
class PaymentButtonController extends _$PaymentButtonController with NotifierMounted {
  @override
  FutureOr<void> build() {
    ref.onDispose(setUnmounted);
    // nothing to do
  }

  Future<void> pay({
    required bool isWeb,
    String? windowUrl,
    void Function(String)? webUrlCallback,
  }) async {
    final checkoutService = ref.read(checkoutServiceProvider);
    state = const AsyncLoading();
    final newState = await AsyncValue.guard(() => checkoutService.pay(
          isWeb: isWeb,
          windowUrl: windowUrl,
          webUrlCallback: webUrlCallback,
        ));
    // * Check if the controller is mounted before setting the state to prevent:
    // * Bad state: Tried to use PaymentButtonController after `dispose` was called.
    if (mounted) {
      state = newState;
    }
  }
}
