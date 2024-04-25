// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myexam/config/app_colors.dart';
import 'package:myexam/utils/questions.dart';
import 'package:myexam/widgets/common_widget/button_view.dart';
import 'package:myexam/widgets/common_widget/toast_view.dart';

import '../../config/app_style.dart';
import '../../controller/exam_controller.dart';
import '../marks/marks_screen.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  List examList = [];

  @override
  void initState() {
    examList = Question.examList;
    super.initState();
  }

  ExamController examController = Get.put(ExamController());

  final PageController pageController = PageController();

  int total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                itemCount: examList.length,
                itemBuilder: (context, index) {
                  return ListView(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryColor.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 13,
                              offset: Offset(0, 15),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Question ${index + 1}",
                              style: AppTextStyle.largeTextStyle.copyWith(
                                fontSize: 20,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              examList[index]["question"],
                              style: AppTextStyle.regularTextStyle
                                  .copyWith(color: AppColors.whiteColor),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: examList[index]["option"].length,
                        itemBuilder: (BuildContext context, int optionIndex) {
                          return ListTile(
                            title: InkWell(
                              onTap: () {
                                examList[index]["grpValue"] = optionIndex;
                                setState(() {});
                              },
                              child: Text(
                                examList[index]["option"][optionIndex],
                                style: AppTextStyle.regularTextStyle
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                            ),
                            leading: Container(
                              width: 24,
                              height: 24,
                              child: Radio(
                                fillColor: MaterialStateColor.resolveWith(
                                  (states) => AppColors.primaryColor,
                                ),
                                value: optionIndex,
                                groupValue: examList[index]["grpValue"],
                                onChanged: (value) {
                                  examList[index]["grpValue"] = value!;
                                  setState(() {});
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Obx(
                        () => ButtonView(
                          onTap: () {
                            if (examList[index]["grpValue"] == -1) {
                              toastView(msg: "Please select answer");
                            } else {
                              if (examController.currentIndex.value <
                                  examList.length - 1) {
                                pageController.nextPage(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                                examController.currentIndex.value++;
                              } else {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MarksScreen(
                                        examList: examList, total: total),
                                  ),
                                );
                              }
                            }
                            if (examList[index]["grpValue"] ==
                                examList[index]["answer"]) {
                              total++;
                            }
                          },
                          title: examController.currentIndex.value <
                                  examList.length - 1
                              ? "Continue"
                              : "Finish",
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
