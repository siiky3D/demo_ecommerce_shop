import 'package:demo_app/src/constants/app_colors.dart';
import 'package:demo_app/src/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  final String headingText;
  final String hintText;
  final bool obsecureText;
  final Widget suffixIcon;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final int maxLines;
  final bool enabled;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final bool autocorrect;
  final void Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;

  const CustomFormField({
    super.key,
    this.autovalidateMode,
    this.validator,
    this.autocorrect = true,
    this.onEditingComplete,
    this.inputFormatters,
    required this.headingText,
    required this.hintText,
    required this.obsecureText,
    required this.suffixIcon,
    required this.textInputType,
    required this.textInputAction,
    required this.controller,
    required this.maxLines,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            // left: 20,
            // right: 20,
            bottom: 10,
          ),
          child: Text(
            headingText,
            style: KTextStyle.textFieldHeading,
          ),
        ),
        Container(
          // margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            color: AppColors.grayshade,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextFormField(
              maxLines: maxLines,
              controller: controller,
              textInputAction: textInputAction,
              keyboardType: textInputType,
              obscureText: obsecureText,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: KTextStyle.textFieldHintStyle,
                border: InputBorder.none,
                suffixIcon: suffixIcon,
                enabled: enabled,
              ),
              autovalidateMode: autovalidateMode,
              validator: validator,
              autocorrect: autocorrect,
              onEditingComplete: onEditingComplete,
              inputFormatters: inputFormatters,
            ),
          ),
        )
      ],
    );
  }
}
