// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myexam/config/app_style.dart';
import 'package:myexam/controller/exam_detail_controller.dart';
import 'package:myexam/screens/exam/exam_screen.dart';
import 'package:myexam/widgets/common_widget/button_view.dart';

class ExamDetailScreen extends StatefulWidget {
  const ExamDetailScreen({super.key});

  @override
  State<ExamDetailScreen> createState() => _ExamDetailScreenState();
}

class _ExamDetailScreenState extends State<ExamDetailScreen> {
  ExamDetailController examDetailController = Get.put(ExamDetailController());

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
                  "Gangdo",
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
                  examDetailController.examDetail["subject"],
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
                  examDetailController.examDetail["mcq"].toString(),
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
                  examDetailController.examDetail["examDuration"],
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
                  examDetailController.examDetail["date"],
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
                  examDetailController.examDetail["time"],
                  style: AppTextStyle.smallTextStyle,
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 50,
            ),
            ButtonView(
              title: "Continue",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ExamScreen(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
