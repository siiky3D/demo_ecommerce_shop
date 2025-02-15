import 'package:demo_app/src/common_widgets/custom_formfield.dart';
import 'package:demo_app/src/common_widgets/custom_richtext.dart';
import 'package:demo_app/src/common_widgets/primary_button.dart';
import 'package:demo_app/src/constants/app_colors.dart';
import 'package:demo_app/src/constants/app_sizes.dart';
import 'package:demo_app/src/features/authentication/presentation/sign_in/email_password_sign_in_controller.dart';
import 'package:demo_app/src/features/authentication/presentation/sign_in/email_password_sign_in_form_type.dart';
import 'package:demo_app/src/features/authentication/presentation/sign_in/email_password_sign_in_validators.dart';
import 'package:demo_app/src/features/authentication/presentation/sign_in/header/custom_header.dart';
import 'package:demo_app/src/routing/app_router.dart';
import 'package:demo_app/src/utils/async_value_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, required this.formType});
  final EmailPasswordSignInFormType formType;

  static const emailKey = Key('email');
  static const passwordKey = Key('password');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUpContents(formType: formType),
    );
  }
}

class SignUpContents extends ConsumerStatefulWidget {
  const SignUpContents({
    super.key,
    this.onSignedUp,
    required this.formType,
  });

  final VoidCallback? onSignedUp;
  final EmailPasswordSignInFormType formType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpContentsState();
}

class _SignUpContentsState extends ConsumerState<SignUpContents> with EmailAndPasswordValidators {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text;
  String get password => _passwordController.text;

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
            text: 'sign_up'.tr(),
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
                    gapH16,
                    CustomFormField(
                      key: SignUpScreen.emailKey,
                      enabled: !state.isLoading,
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
                      key: SignUpScreen.passwordKey,
                      enabled: !state.isLoading,
                      headingText: "password".tr(),
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.text,
                      hintText: "password_hint".tr(),
                      obsecureText: true,
                      suffixIcon: IconButton(icon: const Icon(Icons.visibility), onPressed: () {}),
                      controller: _passwordController,
                    ),
                    gapH24,
                    PrimaryButton(
                      onPressed: () {},
                      text: 'sign_in'.tr(),
                    ),
                    CustomRichText(
                      discription: "have_account".tr(),
                      text: "sign_in".tr(),
                      onTap: () => context.goNamed(AppRoute.signIn.name),
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
