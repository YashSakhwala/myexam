// ignore_for_file: prefer_const_constructors, deprecated_member_use, sized_box_for_whitespace

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myexam/config/app_colors.dart';
import 'package:myexam/controller/exam_detail_controller.dart';
import 'package:myexam/widgets/common_widget/alert_dialog_box_view.dart';
import 'package:myexam/widgets/common_widget/button_view.dart';
import 'package:myexam/widgets/common_widget/toast_view.dart';
import '../../config/app_style.dart';

class ExamScreen extends StatefulWidget {
  final Map question;
  final int index;

  const ExamScreen({
    super.key,
    required this.index,
    required this.question,
  });

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  ExamDetailController examDetailController = Get.put(ExamDetailController());
  final PageController pageController = PageController();

  int totalRightQuestion = 0;
  int currentIndex = 0;

  late Timer _timer;
  int _start = 0;
  String timeValue = "";

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            examDetailController.addQuestion(
              questionList: widget.question,
              rightQuestion: totalRightQuestion,
              context: context,
            );
          });
        } else {
          setState(() {
            timeValue = formatSeconds(_start);
            _start--;
          });
        }
      },
    );
  }

  String formatSeconds(int seconds) {
    int hours = seconds ~/ 3600;
    seconds %= 3600;
    int minutes = seconds ~/ 60;
    seconds %= 60;

    String result = '';
    if (hours > 0) {
      result += '$hours hour${hours > 1 ? 's' : ''} ';
    }
    if (minutes > 0) {
      result += '$minutes minute${minutes > 1 ? 's' : ''} ';
    }
    if (seconds > 0) {
      result += '$seconds second${seconds > 1 ? 's' : ''} ';
    }

    return result.trim();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  int convertSeconds() {
    int differenceInSeconds = 0;

    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('h:mm a');
    DateTime givenTime = dateFormat.parse(widget.question["time"]);

    givenTime = DateTime(
      now.year,
      now.month,
      now.day,
      givenTime.hour,
      givenTime.minute,
    );

    differenceInSeconds = now.difference(givenTime).inSeconds;

    String timeString = widget.question["examDuration"];
    List<String> timeParts = timeString.split(':');

    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    int totalMinutes = (hours * 60) + minutes;
    int totalSeconds = totalMinutes * 60;

    return totalSeconds - differenceInSeconds;
  }

  @override
  void initState() {
    _start = convertSeconds();
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showAlertDialogBox(
            context: context,
            buttonYesTitle: "Exit",
            yesOnTap: () {
              examDetailController.addQuestion(
                questionList: widget.question,
                rightQuestion: totalRightQuestion,
                context: context,
              );
            },
            buttonNoTitle: "Cancel",
            noOnTap: () {
              Navigator.of(context).pop();
            },
            title: "Exit Exam",
            subTitle:
                "Are you sure you want to exit the exam? Your progress will be lost.");
        return false;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    size: 25,
                    color: AppColors.greyColor,
                  ),
                  Text(
                    timeValue,
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 20,
                      color: AppColors.greyColor,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: pageController,
                  itemCount: widget.question["questions"].length,
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
                                widget.question["questions"][index]["question"],
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
                          itemCount: widget
                              .question["questions"][index]["options"].length,
                          itemBuilder: (BuildContext context, int optionIndex) {
                            return ListTile(
                              title: InkWell(
                                onTap: () {
                                  widget.question["questions"][index]
                                      ["grpValue"] = optionIndex + 1;

                                  setState(() {});
                                },
                                child: Text(
                                  widget.question["questions"][index]["options"]
                                      [optionIndex],
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
                                  value: optionIndex + 1,
                                  groupValue: widget.question["questions"]
                                      [index]["grpValue"],
                                  onChanged: (value) {
                                    widget.question["questions"][index]
                                        ["grpValue"] = value;

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
                        ButtonView(
                          onTap: () {
                            if (widget.question["questions"][index]["grpValue"]
                                    .toString() ==
                                widget.question["questions"][index]["answer"]
                                    .toString()) {
                              totalRightQuestion++;
                            }

                            if (widget.question["questions"][index]["grpValue"]
                                    .toString() ==
                                "-1") {
                              toastView(msg: "Please select answer");
                            } else {
                              if (currentIndex <
                                  widget.question["questions"].length - 1) {
                                pageController.nextPage(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );

                                currentIndex++;
                              } else {
                                if (examDetailController
                                    .homeScreenExam.isNotEmpty) {
                                  examDetailController.historyScreenExam.add(
                                      examDetailController
                                          .homeScreenExam[widget.index]);
                                  examDetailController.homeScreenExam
                                      .remove(widget.index);
                                }

                                examDetailController.addQuestion(
                                  questionList: widget.question,
                                  rightQuestion: totalRightQuestion,
                                  context: context,
                                );
                              }
                            }
                          },
                          title: currentIndex <
                                  widget.question["questions"].length - 1
                              ? "Next"
                              : "Finish",
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
