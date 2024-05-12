// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myexam/config/app_colors.dart';
import 'package:myexam/config/app_image.dart';
import 'package:myexam/config/app_style.dart';
import 'package:myexam/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:myexam/screens/checking/checking_screen.dart';
import 'package:myexam/widgets/common_widget/button_view.dart';
import '../../widgets/common_widget/circular_seek_bar_view.dart';

class MarksScreen extends StatefulWidget {
  final Map questionsList;
  final int rightQuestions;
  final int percentage;

  const MarksScreen({
    super.key,
    required this.questionsList,
    required this.rightQuestions,
    required this.percentage,
  });

  @override
  State<MarksScreen> createState() => _MarksScreenState();
}

class _MarksScreenState extends State<MarksScreen> {
  double percentage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: ListView(
          children: [
            Center(
              child: Text(
                "Review",
                style: AppTextStyle.largeTextStyle
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.rightQuestions}/${widget.questionsList["questions"].length}",
                  style: AppTextStyle.regularTextStyle,
                ),
                Column(
                  children: [
                    Text(
                      "You are right",
                      style: AppTextStyle.largeTextStyle.copyWith(fontSize: 20),
                    ),
                    Text(
                      "${widget.percentage}%",
                      style: AppTextStyle.regularTextStyle
                          .copyWith(color: AppColors.primaryColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      size: 21,
                      color: AppColors.greyColor,
                    ),
                    Text(
                      widget.questionsList["examDuration"],
                      style: AppTextStyle.regularTextStyle
                          .copyWith(color: AppColors.greyColor),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: widget.questionsList["questions"].length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CheckingScreen(
                        index: index,
                        questionsList: widget.questionsList["questions"],
                      ),
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.all(4),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.greyColor.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 53,
                          width: 53,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primaryColor),
                            color: widget.questionsList["quesions"][index]
                                        ["grpValue"] ==
                                    -1
                                ? AppColors.redColor
                                : widget.questionsList["questions"][index]
                                                ["grpValue"]
                                            .toString() ==
                                        widget.questionsList["questions"][index]
                                                ["answer"]
                                            .toString()
                                    ? AppColors.greenColor
                                    : AppColors.redColor,
                          ),
                          child: Center(
                            child: Image.asset(
                              widget.questionsList["quesions"][index]
                                          ["grpValue"] ==
                                      -1
                                  ? AppImages.wrong
                                  : widget.questionsList["questions"][index]
                                                  ["grpValue"]
                                              .toString() ==
                                          widget.questionsList["questions"]
                                                  [index]["answer"]
                                              .toString()
                                      ? AppImages.right
                                      : AppImages.wrong,
                              height: 30,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Question ${index + 1}",
                          style: AppTextStyle.smallTextStyle
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 25,
        child: Container(
          padding: EdgeInsets.all(20),
          height: 90,
          color: AppColors.whiteColor,
          child: ButtonView(
            onTap: () {
              percentage = widget.percentage.toDouble();

              CircularSeekBarView(
                context: context,
                progress: percentage,
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => BottomBarScreen(),
                    ),
                    (route) => false,
                  );
                },
              );
            },
            title: "Continue",
          ),
        ),
      ),
    );
  }
}
