// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myexam/config/app_colors.dart';
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
  List examList = [
    {
      "question":
          "it has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. it was popularised in 1960s with the release of Letraset sheets containing Lorem lpsum packages, and more recently with desktop",
      "option": [
        "When an unknown printer took a gallery of type and scrambled it to",
        "contrary to popular belief, Lorem lpsum is not simply random text, it has roots in a piece of classical Latin literature from 45 BC",
        "it is a long established fact that a reader will be",
        "many desktop publishing packages and web page editors now use Lorem lpsum"
      ],
      "answer": 2,
      "grpValue": -1,
    },
    {
      "question":
          "Brass gets discoloured in the air because of the presence of which of the following gases in air?",
      "option": ["Oxygen", "Hydrogen Sulphide", "Carbon dioxide", "Nitrogen"],
      "answer": 1,
      "grpValue": -1,
    },
    {
      "question":
          "Consider the following: Pressurized heavy water reactor (PHWR) Fast breeder reactor (FBR) Advanced Heavy Water Reactor(AHWR) The above three represent the stages of India‘s three stage Nuclear Power programme as follows respectively?",
      "option": [
        "Stage I, Stage II, Stage III",
        "Stage II, Stage I, Stage III",
        "Stage III, Stage II, Stage I",
        "Stage II, Stage III, Stage I"
      ],
      "answer": 0,
      "grpValue": -1,
    },
  ];

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
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
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
                                Navigator.push(
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
