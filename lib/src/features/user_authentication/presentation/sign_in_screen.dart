import 'package:demo_app/gen/assets.gen.dart';
import 'package:demo_app/src/common_widgets/custom_formfield.dart';
import 'package:demo_app/src/common_widgets/custom_richtext.dart';
import 'package:demo_app/src/common_widgets/primary_button.dart';
import 'package:demo_app/src/constants/app_colors.dart';
import 'package:demo_app/src/constants/app_sizes.dart';
import 'package:demo_app/src/features/user_authentication/presentation/auth_providers.dart';
import 'package:demo_app/src/features/user_authentication/presentation/widgets/custom_header.dart';
import 'package:demo_app/src/routing/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

final _emailController = TextEditingController();
final _passwordController = TextEditingController();

class _SignInScreenState extends ConsumerState<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.09),
                      child: Assets.images.appIcon.image(),
                    ),
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
                      hintText: "password_hint".tr(),
                      obsecureText: true,
                      suffixIcon: IconButton(icon: const Icon(Icons.visibility), onPressed: () {}),
                      controller: _passwordController,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: InkWell(
                            onTap: () {},
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
                      onPressed: () async {
                        try {
                          await signInWithEmail(
                              _emailController.text, _passwordController.text, ref);
                          if (context.mounted) {
                            context.goNamed(AppRoute.resetPassword.name);
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text("Error: $e")));
                          }
                        }
                      },
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
          ],
        ),
      ),
    );
  }
}
