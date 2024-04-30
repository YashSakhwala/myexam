// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myexam/config/app_colors.dart';
import 'package:myexam/config/app_style.dart';

import '../../utils/validation.dart';

class TextFieldView extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final TextEditingController controller;
  final bool? fullTextView;
  final bool needValidator;
  final bool emailValidator;
  final bool phoneNoValidator;
  final bool passwordValidator;
  final TextInputType? keyboardType;

  const TextFieldView({
    super.key,
    this.labelText,
    this.suffixIcon,
    this.obscureText = false,
    required this.controller,
    this.fullTextView,
    this.hintText,
    this.prefixIcon,
    this.needValidator = false,
    this.emailValidator = false,
    this.phoneNoValidator = false,
    this.passwordValidator = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.primaryColor,
      obscureText: obscureText!,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: fullTextView,
        fillColor: AppColors.whiteColor,
        contentPadding: EdgeInsets.symmetric(
          vertical: fullTextView == true ? 10 : 12,
          horizontal: fullTextView == true ? 17 : 5,
        ),
        enabledBorder: fullTextView == true
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppColors.whiteColor),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyColor),
              ),
        focusedBorder: fullTextView == true
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppColors.whiteColor),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyColor),
              ),
        labelText: labelText,
        labelStyle: AppTextStyle.smallTextStyle.copyWith(
          fontSize: 16,
          color: AppColors.greyColor,
        ),
        hintText: hintText,
        hintStyle: AppTextStyle.smallTextStyle.copyWith(
          fontSize: 16,
          color: AppColors.greyColor,
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      validator: needValidator
          ? (value) => TextFieldValidation.validation(
                isEmailValidator: emailValidator,
                isPasswordValidator: passwordValidator,
                isPhoneNumberValidator: phoneNoValidator,
                message: labelText,
                value: value,
              )
          : null,
    );
  }
}
