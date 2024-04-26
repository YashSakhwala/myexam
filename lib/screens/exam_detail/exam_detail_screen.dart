// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myexam/config/app_style.dart';
import 'package:myexam/screens/exam/exam_screen.dart';
import 'package:myexam/widgets/common_widget/button_view.dart';

class ExamDetailScreen extends StatefulWidget {
  const ExamDetailScreen({super.key});

  @override
  State<ExamDetailScreen> createState() => _ExamDetailScreenState();
}

class _ExamDetailScreenState extends State<ExamDetailScreen> {
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
                  width: 52,
                ),
                Text(
                  "Engilsh",
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
                  width: 58,
                ),
                Text(
                  "10",
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
                  width: 99,
                ),
                Text(
                  "31/02/1524",
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
                  width: 95,
                ),
                Text(
                  "12:00",
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
