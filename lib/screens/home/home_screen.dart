// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:myexam/config/app_colors.dart';
import 'package:myexam/config/app_image.dart';
import 'package:myexam/config/app_style.dart';
import 'package:myexam/screens/exam/exam_screen.dart';
import 'package:myexam/widgets/common_widget/button_view.dart';
import 'package:myexam/widgets/common_widget/text_field_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController search = TextEditingController();

  List examList = [
    {"examName": "Math"},
    {"examName": "English"},
    {"examName": "Physical"},
    {"examName": "Chemistry"},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 240,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(60)),
                color: AppColors.primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello,",
                              style: AppTextStyle.regularTextStyle.copyWith(
                                fontSize: 15,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            Text(
                              "Lukasz",
                              style: AppTextStyle.largeTextStyle.copyWith(
                                fontSize: 35,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            Text(
                              "Let's workout to get some gains",
                              style: AppTextStyle.smallTextStyle.copyWith(
                                fontSize: 12,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        CircleAvatar(
                          maxRadius: 38,
                          backgroundColor: AppColors.whiteColor,
                          backgroundImage: Image.asset(AppImages.boy).image,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 220,
                          child: TextFieldView(
                            controller: search,
                            fullTextView: true,
                            hintText: "Enter exam code",
                          ),
                        ),
                        Spacer(),
                        ButtonView(
                          title: "Submit",
                          height: 50,
                          width: 100,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 250,
                ),
                itemCount: examList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ExamScreen(),
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: Image.asset(
                            AppImages.exam,
                          ).image,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.srgbToLinearGamma(),
                        ),
                      ),
                      child: Column(
                        children: [
                          ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                              child: Container(
                                width: 120,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  color: AppColors.whiteColor.withOpacity(0.5),
                                ),
                                child: Center(
                                  child: Text(
                                    examList[index]["examName"],
                                    style: AppTextStyle.largeTextStyle.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
