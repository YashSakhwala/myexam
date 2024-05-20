// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myexam/config/app_colors.dart';
import 'package:myexam/config/app_style.dart';
import 'package:myexam/controller/exam_detail_controller.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  ExamDetailController examDetailController = Get.put(ExamDetailController());

  @override
  void initState() {
    examDetailController.getStudentData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => examDetailController.isLoader.value == true
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  strokeWidth: 2,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    Center(
                      child: Text(
                        "Leaderboard",
                        style:
                            AppTextStyle.largeTextStyle.copyWith(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: examDetailController.studentData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            height: 75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: index.isEven
                                  ? AppColors.whiteColor
                                  : AppColors.primaryColor.withOpacity(0.1),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.greyColor.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        color: AppColors.primaryColor,
                                        strokeWidth: 2,
                                      ),
                                      Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: AppColors.primaryColor),
                                          image: DecorationImage(
                                            image: Image.network(
                                              examDetailController
                                                  .studentData[index]["image"],
                                            ).image,
                                            scale: 9,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          examDetailController
                                              .studentData[index]["name"],
                                          style: AppTextStyle.largeTextStyle
                                              .copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "${examDetailController.studentData[index]["percentage"]} %",
                                          style: AppTextStyle.smallTextStyle
                                              .copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: AppColors.primaryColor),
                                      color: index == 0
                                          ? AppColors.yellowColor
                                          : index == 1
                                              ? AppColors.brownColor
                                                  .withOpacity(0.3)
                                              : index == 2
                                                  ? AppColors.pinkColor
                                                      .withOpacity(0.4)
                                                  : AppColors.primaryColor
                                                      .withOpacity(0.07),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${index + 1}",
                                        style: AppTextStyle.regularTextStyle
                                            .copyWith(
                                          color: index == 0
                                              ? AppColors.redColor
                                              : AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
