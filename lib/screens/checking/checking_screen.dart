// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_style.dart';

class CheckingScreen extends StatefulWidget {
  final List questionsList;
  final int index;

  const CheckingScreen({
    super.key,
    required this.index,
    required this.questionsList,
  });

  @override
  State<CheckingScreen> createState() => _CheckingScreenState();
}

class _CheckingScreenState extends State<CheckingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
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
                    widget.questionsList[widget.index]["question"],
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
              itemCount: widget.questionsList[widget.index]["options"].length,
              itemBuilder: (BuildContext context, int optionIndex) {
                return ListTile(
                  title: Text(
                    widget.questionsList[widget.index]["options"][optionIndex],
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      color: widget.questionsList[widget.index]["answer"]
                                  .toString() ==
                              (optionIndex + 1).toString()
                          ? AppColors.greenColor
                          : widget.questionsList[widget.index]["grpValue"]
                                      .toString() ==
                                  (optionIndex + 1).toString()
                              ? AppColors.redColor
                              : AppColors.blackColor,
                    ),
                  ),
                  leading: Container(
                    width: 24,
                    height: 24,
                    child: Radio(
                      fillColor: MaterialStateColor.resolveWith(
                        (states) => widget.questionsList[widget.index]["answer"]
                                    .toString() ==
                                (optionIndex + 1).toString()
                            ? AppColors.greenColor
                            : widget.questionsList[widget.index]["grpValue"]
                                        .toString() ==
                                    (optionIndex + 1).toString()
                                ? AppColors.redColor
                                : AppColors.blackColor,
                      ),
                      value: optionIndex + 1,
                      groupValue: widget.questionsList[widget.index]
                          ["grpValue"],
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
