import 'package:demo_app/src/constants/app_colors.dart';
import 'package:demo_app/src/constants/app_sizes.dart';
import 'package:demo_app/src/constants/text_styles.dart';
import 'package:flutter/material.dart';

/// Primary button based on [ElevatedButton].
/// Useful for CTAs in the app.
/// @param text - text to display on the button.
/// @param isLoading - if true, a loading indicator will be displayed instead of
/// the text.
/// @param onPressed - callback to be called when the button is pressed.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.text, this.isLoading = false, this.onPressed});
  final String text;
  final bool isLoading;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.p48,
      child: InkWell(
        onTap: onPressed,
        child: isLoading
            ? const CircularProgressIndicator()
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.05,
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: const BoxDecoration(
                    color: AppColors.blue, borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: KTextStyle.authButtonTextStyle,
                  ),
                ),
              ),
      ),
    );
  }
}
