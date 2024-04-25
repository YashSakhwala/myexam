import 'package:flutter/material.dart';
import 'package:myexam/config/app_colors.dart';
import 'package:myexam/config/app_style.dart';

class ButtonView extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final Function() onTap;
  final Color? containerColor;
  final Color? titleColor;
  const ButtonView({
    super.key,
    this.height,
    this.width,
    required this.title,
    required this.onTap,
    this.containerColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 55,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.whiteColor),
          color: containerColor ?? AppColors.primaryColor,
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyle.largeTextStyle.copyWith(
              fontSize: 16,
              color: titleColor ?? AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
