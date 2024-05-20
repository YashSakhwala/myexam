// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myexam/config/app_colors.dart';
import 'package:myexam/config/app_style.dart';
import '../../utils/validation.dart';

class TextFieldView extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final TextEditingController controller;
  final bool? fullTextView;
  final bool needValidator;
  final bool nameValidator;
  final bool emailValidator;
  final bool phoneNoValidator;
  final bool passwordValidator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final TextStyle? style;

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
    this.nameValidator = false,
    this.emailValidator = false,
    this.phoneNoValidator = false,
    this.passwordValidator = false,
    this.keyboardType,
    this.inputFormatters,
    this.enabled,
    this.style,
  });

  @override
  State<TextFieldView> createState() => _TextFieldViewState();
}

class _TextFieldViewState extends State<TextFieldView> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style:
          widget.style ?? AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      cursorColor: AppColors.primaryColor,
      obscureText: widget.obscureText!,
      decoration: InputDecoration(
        filled: widget.fullTextView,
        fillColor: AppColors.whiteColor,
        contentPadding: EdgeInsets.symmetric(
          vertical: widget.fullTextView == true ? 10 : 12,
          horizontal: widget.fullTextView == true ? 17 : 5,
        ),
        enabledBorder: widget.fullTextView == true
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppColors.whiteColor),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyColor),
              ),
        focusedBorder: widget.fullTextView == true
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppColors.whiteColor),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyColor),
              ),
        labelText: widget.labelText,
        labelStyle: AppTextStyle.smallTextStyle.copyWith(
          fontSize: 16,
          color: AppColors.greyColor,
        ),
        hintText: widget.hintText,
        hintStyle: AppTextStyle.smallTextStyle.copyWith(
          fontSize: 16,
          color: AppColors.greyColor,
        ),
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
      ),
      validator: widget.needValidator
          ? (value) => TextFieldValidation.validation(
                isEmailValidator: widget.emailValidator,
                isPasswordValidator: widget.passwordValidator,
                isPhoneNumberValidator: widget.phoneNoValidator,
                message: widget.labelText,
                value: value,
              )
          : null,
    );
  }
}
