import 'package:demo_app/src/constants/string_hardcoded.dart';
import 'package:easy_localization/easy_localization.dart';

enum EmailPasswordSignInFormType { signIn, register }

extension EmailPasswordSignInFormTypeX on EmailPasswordSignInFormType {
  String get passwordLabelText {
    if (this == EmailPasswordSignInFormType.register) {
      return "auth.password_label_register".tr();
    } else {
      return "auth.password_label".tr();
    }
  }

  // Getters
  String get primaryButtonText {
    if (this == EmailPasswordSignInFormType.register) {
      return "auth.primary_button_register".tr();
    } else {
      return "auth.primary_button_sign_in".tr();
    }
  }

  String get secondaryButtonText {
    if (this == EmailPasswordSignInFormType.register) {
      return "auth.secondary_button_register".tr();
    } else {
      return "auth.secondary_button_sign_in".tr();
    }
  }

  EmailPasswordSignInFormType get secondaryActionFormType {
    if (this == EmailPasswordSignInFormType.register) {
      return EmailPasswordSignInFormType.signIn;
    } else {
      return EmailPasswordSignInFormType.register;
    }
  }

  String get errorAlertTitle {
    if (this == EmailPasswordSignInFormType.register) {
      return "auth.error_alert_register".tr();
    } else {
      return "auth.error_alert_sign_in".tr();
    }
  }

  String get title {
    if (this == EmailPasswordSignInFormType.register) {
      return "auth.title_register".tr();
    } else {
      return "auth.title_sign_in".tr();
    }
  }
}
