// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myexam/config/app_style.dart';
import 'package:myexam/controller/exam_detail_controller.dart';
import '../../config/app_colors.dart';
import '../../widgets/common_widget/button_view.dart';
import '../exam/exam_screen.dart';

class ExamDetailScreen extends StatefulWidget {
  final Map question;
  final int index;

  const ExamDetailScreen({
    super.key,
    required this.question,
    required this.index,
  });

  @override
  State<ExamDetailScreen> createState() => _ExamDetailScreenState();
}

class _ExamDetailScreenState extends State<ExamDetailScreen> {
  ExamDetailController examDetailController = Get.put(ExamDetailController());

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
    int days = seconds ~/ (24 * 3600);
    seconds %= (24 * 3600);
    int hours = seconds ~/ 3600;
    seconds %= 3600;
    int minutes = seconds ~/ 60;
    seconds %= 60;

    String result = '';
    if (days > 0) {
      result += '$days day${days > 1 ? 's' : ''} ';
    }
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

  int calculateTimeDifferenceInSeconds(String givenDate, String givenTime) {
    DateTime currentDateTime = DateTime.now();

    DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm a");
    DateTime givenDateTime = dateFormat.parse("$givenDate $givenTime");

    int differenceInSeconds =
        givenDateTime.difference(currentDateTime).inSeconds;

    return differenceInSeconds;
  }

  @override
  void initState() {
    DateTime currentDateTime = DateTime.now();

    DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm a");
    DateTime givenDateTime = dateFormat
        .parse("${widget.question["date"]} ${widget.question["time"]}");

    bool isTimeCheck = givenDateTime.isBefore(currentDateTime);

    if (isTimeCheck != true) {
      _start = calculateTimeDifferenceInSeconds(
          widget.question["date"], widget.question["time"]);
    } else {
      _start = 0;
    }
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Exam details",
                style: AppTextStyle.regularTextStyle.copyWith(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Row(
              children: [
                Text(
                  "Teacher name: ",
                  style: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
                ),
                SizedBox(
                  width: 35,
                ),
                Text(
                  widget.question["teacherName"],
                  style: AppTextStyle.smallTextStyle,
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Exam name: ",
                  style: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
                ),
                SizedBox(
                  width: 56,
                ),
                Text(
                  widget.question["subject"],
                  style: AppTextStyle.smallTextStyle,
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Exam code: ",
                  style: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
                ),
                SizedBox(
                  width: 60,
                ),
                Text(
                  widget.question["code"].toString(),
                  style: AppTextStyle.smallTextStyle,
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Total MCQ: ",
                  style: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
                ),
                SizedBox(
                  width: 67,
                ),
                Text(
                  widget.question["mcq"].toString(),
                  style: AppTextStyle.smallTextStyle,
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Exam duration: ",
                  style: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
                ),
                SizedBox(
                  width: 36,
                ),
                Text(
                  widget.question["examDuration"],
                  style: AppTextStyle.smallTextStyle,
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Date: ",
                  style: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
                ),
                SizedBox(
                  width: 115,
                ),
                Text(
                  widget.question["date"],
                  style: AppTextStyle.smallTextStyle,
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Time: ",
                  style: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
                ),
                SizedBox(
                  width: 112,
                ),
                Text(
                  widget.question["time"],
                  style: AppTextStyle.smallTextStyle,
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 70,
            ),
            _start == 0
                ? ButtonView(
                    title: "Continue",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ExamScreen(
                          question: widget.question,
                          index: widget.index,
                        ),
                      ));
                    },
                  )
                : Center(
                    child: Text(
                      "Exam will start in\n$timeValue",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.regularTextStyle.copyWith(
                        color: AppColors.redColor,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
