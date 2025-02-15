import 'package:demo_app/src/common_widgets/custom_formfield.dart';
import 'package:demo_app/src/common_widgets/primary_button.dart';
import 'package:demo_app/src/constants/app_sizes.dart';
import 'package:demo_app/src/features/authentication/presentation/sign_in/email_password_sign_in_controller.dart';
import 'package:demo_app/src/routing/app_router.dart';
import 'package:demo_app/src/exceptions/auth_exceptions_handler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  static const String id = 'reset_password';
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  static final auth = FirebaseAuth.instance;
  static late AuthStatus _status;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<AuthStatus> resetPassword({required String email}) async {
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) => _status = AuthStatus.successful)
        .catchError((e) => _status = AuthExceptionHandler.handleAuthException(e));

    return _status;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(emailPasswordSignInControllerProvider);

    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: const Icon(Icons.close),
                ),
                gapH24,
                const Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                gapH12,
                const Text(
                  'Please enter your email address to recover your password.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                gapH32,
                CustomFormField(
                  enabled: !state.isLoading,
                  controller: _emailController,
                  headingText: "email".tr(),
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.text,
                  hintText: "email".tr(),
                  obsecureText: false,
                  suffixIcon: const SizedBox(),

                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Empty email';
                  //   }
                  //   return null;
                  // },
                ),
                gapH16,
                const Expanded(child: SizedBox()),
                PrimaryButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      final status = await resetPassword(email: _emailController.text.trim());
                      if (status == AuthStatus.successful) {
                        //your logic
                      } else {
                        //your logic or show snackBar with error message
                      }
                    }
                  },
                  isLoading: false,
                  text: 'RECOVER PASSWORD',
                ),
                gapH20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
