// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:myexam/controller/exam_detail_controller.dart';
import '../../config/app_colors.dart';
import '../../config/app_image.dart';
import '../../config/app_style.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  ExamDetailController examDetailController = Get.put(ExamDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "History",
              style: AppTextStyle.largeTextStyle.copyWith(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Obx(
            () => examDetailController.isLoader.value == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                      strokeWidth: 2,
                    ),
                  )
                : examDetailController.historyScreenExam.isEmpty
                    ? Center(
                        child: Lottie.asset("assets/lottie/empty.json"),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 250,
                        ),
                        itemCount:
                            examDetailController.historyScreenExam.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              examDetailController.getQuestion(
                                code: examDetailController
                                    .historyScreenExam[index]["code"],
                                examDuration: examDetailController
                                    .historyScreenExam[index]["examDuration"],
                                context: context,
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                  image: Image.asset(
                                    AppImages.exam,
                                  ).image,
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.srgbToLinearGamma(),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 3, sigmaY: 3),
                                      child: Container(
                                        width: 120,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                          color: AppColors.whiteColor
                                              .withOpacity(0.5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            examDetailController
                                                    .historyScreenExam[index]
                                                ["subject"],
                                            style: AppTextStyle.largeTextStyle
                                                .copyWith(
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
