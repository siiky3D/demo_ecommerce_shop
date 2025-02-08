import 'package:demo_app/gen/assets.gen.dart';
import 'package:demo_app/src/features/onboarding/presentation/onboarding_controller.dart';
import 'package:demo_app/src/routing/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);

    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "welcome1".tr(),
          body: "welcome1Instruction".tr(),
          image: Lottie.asset(Assets.lotties.welcomScreenImage1),
        ),
        PageViewModel(
          title: "welcome2".tr(),
          body: "welcome2Instruction".tr(),
          image: Lottie.asset(Assets.lotties.welcomScreenImage2),
        ),
        PageViewModel(
          title: "welcome3".tr(),
          body: "welcome3Instruction".tr(),
          image: Lottie.asset(Assets.lotties.welcomScreenImage3),
        ),
      ],
      onDone: state.isLoading
          ? null
          : () async {
              await ref.read(onboardingControllerProvider.notifier).completeOnboarding();
              if (context.mounted) {
                context.goNamed(AppRoute.signIn.name);
              }
            },
      showSkipButton: true,
      skip: Text("skip".tr()),
      next: Icon(Icons.arrow_forward),
      done: Text("start".tr(), style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
