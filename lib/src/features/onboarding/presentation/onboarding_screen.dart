import 'package:demo_ecommerce_shop/gen/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
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
      onDone: () {},
      showSkipButton: true,
      skip: Text("skip".tr()),
      next: Icon(Icons.arrow_forward),
      done: Text("start".tr(), style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
