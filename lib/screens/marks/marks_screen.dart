// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myexam/config/app_colors.dart';
import 'package:myexam/config/app_image.dart';
import 'package:myexam/config/app_style.dart';
import 'package:myexam/screens/checking/checking_screen.dart';
import 'package:myexam/widgets/common_widget/button_view.dart';
import '../../widgets/common_widget/alert_dialog_box_view.dart';

class MarksScreen extends StatefulWidget {
  final List examList;
  final int total;

  const MarksScreen({
    super.key,
    required this.examList,
    required this.total,
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
                  "${widget.total}/${widget.examList.length}",
                  style: AppTextStyle.regularTextStyle,
                ),
                Column(
                  children: [
                    Text(
                      "You are right",
                      style: AppTextStyle.largeTextStyle.copyWith(fontSize: 20),
                    ),
                    Text(
                      "${(widget.total / widget.examList.length * 100).round()}%",
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
                      "12:00",
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
              itemCount: widget.examList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CheckingScreen(index: index),
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
                            color: index.isEven
                                ? AppColors.greenColor
                                : AppColors.redColor,
                          ),
                          child: Center(
                            child: Image.asset(
                              widget.examList[index]["grpValue"] ==
                                      widget.examList[index]["answer"]
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
              percentage = (widget.total / widget.examList.length * 100);
              alertDialogBoxView(context: context, progress: percentage);
            },
            title: "Continue",
          ),
        ),
      ),
    );
  }
}
