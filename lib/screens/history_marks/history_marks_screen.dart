// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myexam/controller/exam_detail_controller.dart';
import '../../config/app_colors.dart';
import '../../config/app_image.dart';
import '../../config/app_style.dart';
import '../checking/checking_screen.dart';

class HistoryMarksScreen extends StatefulWidget {
  final String examDuration;

  const HistoryMarksScreen({
    super.key,
    required this.examDuration,
  });

  @override
  State<HistoryMarksScreen> createState() => _HistoryMarksScreenState();
}

class _HistoryMarksScreenState extends State<HistoryMarksScreen> {
  ExamDetailController examDetailController = Get.put(ExamDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: ListView(
          children: [
            Center(
              child: Text(
                "Review",
                style: AppTextStyle.largeTextStyle
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${examDetailController.examResult["right"]}/${examDetailController.examResult["total"]}",
                  style: AppTextStyle.regularTextStyle,
                ),
                Column(
                  children: [
                    Text(
                      "You are right",
                      style: AppTextStyle.largeTextStyle.copyWith(fontSize: 20),
                    ),
                    Text(
                      "${(examDetailController.examResult["right"] / examDetailController.examResult["total"] * 100).toStringAsFixed(2)} %",
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
                      widget.examDuration,
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
              itemCount: examDetailController.examResult["total"],
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CheckingScreen(
                        index: index,
                        questionsList:
                            examDetailController.examResult["answer"],
                      ),
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
                            color: examDetailController.examResult["answer"]
                                            [index]["grpValue"]
                                        .toString() ==
                                    examDetailController.examResult["answer"]
                                            [index]["answer"]
                                        .toString()
                                ? AppColors.greenColor
                                : AppColors.redColor,
                          ),
                          child: Center(
                            child: Image.asset(
                              examDetailController.examResult["answer"][index]
                                              ["grpValue"]
                                          .toString() ==
                                      examDetailController.examResult["answer"]
                                              [index]["answer"]
                                          .toString()
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
