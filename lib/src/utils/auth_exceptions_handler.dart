import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  successful,
  wrongPassword,
  emailAlreadyExists,
  invalidEmail,
  weakPassword,
  unknown,
}

class AuthExceptionHandler {
  static handleAuthException(FirebaseAuthException e) {
    AuthStatus status;
    switch (e.code) {
      case "invalid-email":
        status = AuthStatus.invalidEmail;
        break;
      case "wrong-password":
        status = AuthStatus.wrongPassword;
        break;
      case "weak-password":
        status = AuthStatus.weakPassword;
        break;
      case "email-already-in-use":
        status = AuthStatus.emailAlreadyExists;
        break;
      default:
        status = AuthStatus.unknown;
    }
    return status;
  }

  static String generateErrorMessage(error) {
    switch (error) {
      case AuthStatus.invalidEmail:
        return "firebase_auth_error.invalid_email".tr();
      case AuthStatus.weakPassword:
        return "firebase_auth_error.weak_password".tr();
      case AuthStatus.wrongPassword:
        return "firebase_auth_error.wrong_password".tr();
      case AuthStatus.emailAlreadyExists:
        return "firebase_auth_error.email_already_exists".tr();
      default:
        return "firebase_auth_error.unknown".tr();
    }
  }
}
