// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_style.dart';
import '../../utils/questions.dart';

class CheckingScreen extends StatefulWidget {
  final int index;

  const CheckingScreen({
    super.key,
    required this.index,
  });

  @override
  State<CheckingScreen> createState() => _CheckingScreenState();
}

class _CheckingScreenState extends State<CheckingScreen> {
  List examList = [];

  @override
  void initState() {
    examList = Question.examList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                    "Question ${widget.index + 1}",
                    style: AppTextStyle.largeTextStyle.copyWith(
                      fontSize: 20,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    examList[widget.index]["question"],
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
              itemCount: examList[widget.index]["option"].length,
              itemBuilder: (BuildContext context, int optionIndex) {
                return ListTile(
                  title: Text(
                    examList[widget.index]["option"][optionIndex],
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      color: examList[widget.index]["answer"] == optionIndex
                          ? AppColors.greenColor
                          : examList[widget.index]["grpValue"] != optionIndex
                              ? AppColors.blackColor
                              : AppColors.redColor,
                    ),
                  ),
                  leading: Container(
                    width: 24,
                    height: 24,
                    child: Radio(
                      fillColor: MaterialStateColor.resolveWith(
                        (states) => examList[widget.index]["answer"] ==
                                optionIndex
                            ? AppColors.greenColor
                            : examList[widget.index]["grpValue"] != optionIndex
                                ? AppColors.blackColor
                                : AppColors.redColor,
                      ),
                      value: optionIndex,
                      groupValue: examList[widget.index]["grpValue"],
                      onChanged: (value) {},
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
