// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myexam/config/app_colors.dart';
import 'package:myexam/config/app_style.dart';
import 'package:myexam/widgets/common_widget/button_view.dart';
import 'package:circular_seek_bar/circular_seek_bar.dart';

void alertDialogBoxView(BuildContext context) {
  double progressValue = 70;

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Container(
          width: double.infinity,
          height: 250,
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor.withOpacity(0.7),
          ),
          child: CircularSeekBar(
            width: double.infinity,
            height: double.infinity,
            progress: progressValue,
            barWidth: 12,
            startAngle: 180,
            sweepAngle: 360,
            trackColor: AppColors.primaryColor,
            progressColor: AppColors.whiteColor,
            outerThumbRadius: 6,
            outerThumbStrokeWidth: 10,
            outerThumbColor: AppColors.whiteColor,
            child: Center(
              child: Text(
                "70%",
                style: AppTextStyle.regularTextStyle.copyWith(
                  fontSize: 40,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
        ),
        actions: [
          SizedBox(
            height: 40,
          ),
          ButtonView(
            onTap: () {
              Navigator.of(context).pop();
            },
            title: "Go to Home",
          ),
        ],
      );
    },
  );
}
