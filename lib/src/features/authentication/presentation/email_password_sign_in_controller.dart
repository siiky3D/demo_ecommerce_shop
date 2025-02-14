import 'dart:async';

import 'package:demo_app/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:demo_app/src/features/authentication/presentation/email_password_sign_in_form_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'email_password_sign_in_controller.g.dart';

@riverpod
class EmailPasswordSignInController extends _$EmailPasswordSignInController {
  bool _isPasswordVisible = false;
  bool _isRememberMe = false;
  @override
  FutureOr<void> build() {}

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isRememberMe => _isRememberMe;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    ref.notifyListeners();
  }

  void toggleRememberMe() {
    _isRememberMe = !_isRememberMe;
    ref.notifyListeners();
  }

  Future<bool> submit({
    required String email,
    required String password,
    required EmailPasswordSignInFormType formType,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _authenticate(email, password, formType));
    return state.hasError == false;
  }

  Future<void> _authenticate(String email, String password, EmailPasswordSignInFormType formType) {
    final authRepository = ref.read(authRepositoryProvider);
    switch (formType) {
      case EmailPasswordSignInFormType.signIn:
        return authRepository.signInWithEmailAndPassword(email, password);
      case EmailPasswordSignInFormType.register:
        return authRepository.createUserWithEmailAndPassword(email, password);
    }
  }
}
