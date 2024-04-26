// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myexam/controller/exam_controller.dart';
import 'package:myexam/screens/leaderboard/leaderboard_screen.dart';
import '../../config/app_colors.dart';
import '../../config/app_image.dart';
import '../../config/app_style.dart';
import '../checking/checking_screen.dart';

class HistoryMarksScreen extends StatefulWidget {
  const HistoryMarksScreen({super.key});

  @override
  State<HistoryMarksScreen> createState() => _HistoryMarksScreenState();
}

class _HistoryMarksScreenState extends State<HistoryMarksScreen> {
  ExamController examController = Get.put(ExamController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: ListView(
          children: [
            Row(
              children: [
                Spacer(),
                Text(
                  "Review",
                  style: AppTextStyle.largeTextStyle
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LeaderBoardScreen(),
                    ));
                  },
                  child: Image.asset(
                    AppImages.blankTrophy,
                    height: 23,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${examController.marksData.total}/${examController.marksData.examList.length}",
                  style: AppTextStyle.regularTextStyle,
                ),
                Column(
                  children: [
                    Text(
                      "You are right",
                      style: AppTextStyle.largeTextStyle.copyWith(fontSize: 20),
                    ),
                    Text(
                      "${(examController.marksData.total! / examController.marksData.examList.length * 100).round()}%",
                      style: AppTextStyle.regularTextStyle
                          .copyWith(color: AppColors.primaryColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      size: 21,
                      color: AppColors.greyColor,
                    ),
                    Text(
                      "12:00",
                      style: AppTextStyle.regularTextStyle
                          .copyWith(color: AppColors.greyColor),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: examController.marksData.examList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CheckingScreen(index: index),
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.all(4),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.greyColor.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 53,
                          width: 53,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primaryColor),
                            color: examController.marksData.examList[index]
                                        ["grpValue"] ==
                                    examController.marksData.examList[index]
                                        ["answer"]
                                ? AppColors.greenColor
                                : AppColors.redColor,
                          ),
                          child: Center(
                            child: Image.asset(
                              examController.marksData.examList[index]
                                          ["grpValue"] ==
                                      examController.marksData.examList[index]
                                          ["answer"]
                                  ? AppImages.right
                                  : AppImages.wrong,
                              height: 30,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Question ${index + 1}",
                          style: AppTextStyle.smallTextStyle
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
