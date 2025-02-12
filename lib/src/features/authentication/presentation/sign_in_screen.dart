import 'package:demo_app/src/common_widgets/custom_formfield.dart';
import 'package:demo_app/src/common_widgets/custom_richtext.dart';
import 'package:demo_app/src/common_widgets/primary_button.dart';
import 'package:demo_app/src/constants/app_colors.dart';
import 'package:demo_app/src/constants/app_sizes.dart';
import 'package:demo_app/src/features/authentication/presentation/email_password_sign_in_controller.dart';
import 'package:demo_app/src/features/authentication/presentation/email_password_sign_in_form_type.dart';
import 'package:demo_app/src/features/authentication/presentation/email_password_sign_in_validators.dart';
import 'package:demo_app/src/features/authentication/presentation/header/custom_header.dart';
import 'package:demo_app/src/routing/app_router.dart';
import 'package:demo_app/src/utils/async_value_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key, required this.formType});
  final EmailPasswordSignInFormType formType;

  // * Keys for testing using find.byKey()
  static const emailKey = Key('email');
  static const passwordKey = Key('password');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInContents(formType: formType),
    );
  }
}

class SignInContents extends ConsumerStatefulWidget {
  const SignInContents({
    super.key,
    this.onSignedIn,
    required this.formType,
  });

  final VoidCallback? onSignedIn;
  final EmailPasswordSignInFormType formType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInContentsState();
}

class _SignInContentsState extends ConsumerState<SignInContents> with EmailAndPasswordValidators {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text;
  String get password => _passwordController.text;

  var _submitted = false;
  // track the formType as a local state variable
  late var _formType = widget.formType;

  @override
  void dispose() {
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (!_formKey.currentState!.validate()) {
      final controller = ref.read(emailPasswordSignInControllerProvider.notifier);
      final success = await controller.submit(
        email: email,
        password: password,
        formType: _formType,
      );

      if (success) {
        widget.onSignedIn?.call();
      }
    }
  }

  void _emailEditingComplete() {
    if (canSubmitEmail(email)) {
      _node.nextFocus();
    }
  }

  void _passwordEditingComplete() {
    if (!canSubmitEmail(email)) {
      _node.previousFocus();
      return;
    }
    _submit();
  }

  void _updateFormType() {
    // * Toggle between register and sign in form
    setState(() => _formType = _formType.secondaryActionFormType);
    // * Clear the password field when doing so
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      emailPasswordSignInControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final state = ref.watch(emailPasswordSignInControllerProvider);
    return SafeArea(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: AppColors.blue,
          ),
          CustomHeader(
            text: 'log_in'.tr(),
            onTap: () {},
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: AppColors.whiteshade,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40), topRight: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: Sizes.p16, horizontal: Sizes.p24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    gapH24,
                    CustomFormField(
                      headingText: "email".tr(),
                      hintText: "email".tr(),
                      obsecureText: false,
                      suffixIcon: const SizedBox(),
                      controller: _emailController,
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.emailAddress,
                    ),
                    gapH16,
                    CustomFormField(
                      headingText: "password".tr(),
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.text,
                      hintText: "password".tr(),
                      obsecureText: true,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: () {},
                      ),
                      controller: _passwordController,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: InkWell(
                            onTap: () {
                              context.goNamed(AppRoute.resetPassword.name);
                            },
                            child: Text(
                              "forgot_password".tr(),
                              style: TextStyle(
                                  color: AppColors.blue.withAlpha((0.7 * 255).toInt()),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                    PrimaryButton(
                      onPressed: () async {},
                      text: 'sign_in'.tr(),
                    ),
                    CustomRichText(
                      discription: "no_account".tr(),
                      text: "sign_up".tr(),
                      onTap: () {
                        context.goNamed(AppRoute.signUp.name);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
