// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myexam/config/app_colors.dart';
import 'package:myexam/config/app_image.dart';
import 'package:myexam/controller/bottom_bar_controller.dart';
import 'package:myexam/screens/history/history_screen.dart';
import 'package:myexam/screens/home/home_screen.dart';
import 'package:myexam/screens/leaderboard/leaderboard_screen.dart';
import '../setting/setting_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  BottomBarController bottomBarController = Get.put(BottomBarController());

  List BottomBarScreens = [
    HomeScreen(),
    LeaderBoardScreen(),
    HistoryScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        elevation: 25,
        child: Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  bottomBarController.index.value = 0;
                },
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(
                      () => Image.asset(
                          bottomBarController.index.value == 0
                              ? AppImages.fillHome
                              : AppImages.blankHome,
                          height: 25,
                          color: bottomBarController.index.value == 0
                              ? AppColors.primaryColor
                              : AppColors.blackColor),
                    ),
                    Obx(
                      () => Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 12,
                          color: bottomBarController.index.value == 0
                              ? AppColors.primaryColor
                              : AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  bottomBarController.index.value = 1;
                },
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(
                      () => Image.asset(
                          bottomBarController.index.value == 1
                              ? AppImages.fillTrophy
                              : AppImages.blankTrophy,
                          height: 25,
                          color: bottomBarController.index.value == 1
                              ? AppColors.primaryColor
                              : AppColors.blackColor),
                    ),
                    Obx(
                      () => Text(
                        "Leaderboard",
                        style: TextStyle(
                          fontSize: 12,
                          color: bottomBarController.index.value == 1
                              ? AppColors.primaryColor
                              : AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  bottomBarController.index.value = 2;
                },
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(
                      () => Image.asset(
                          bottomBarController.index.value == 2
                              ? AppImages.fillHistory
                              : AppImages.blankHistory,
                          height: 25,
                          color: bottomBarController.index.value == 2
                              ? AppColors.primaryColor
                              : AppColors.blackColor),
                    ),
                    Obx(
                      () => Text(
                        "History",
                        style: TextStyle(
                          fontSize: 12,
                          color: bottomBarController.index.value == 2
                              ? AppColors.primaryColor
                              : AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  bottomBarController.index.value = 3;
                },
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(
                      () => Image.asset(
                          bottomBarController.index.value == 3
                              ? AppImages.fillProfile
                              : AppImages.blankProfile,
                          height: 25,
                          color: bottomBarController.index.value == 3
                              ? AppColors.primaryColor
                              : AppColors.blackColor),
                    ),
                    Obx(
                      () => Text(
                        "Profile",
                        style: TextStyle(
                          fontSize: 12,
                          color: bottomBarController.index.value == 3
                              ? AppColors.primaryColor
                              : AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() => BottomBarScreens[bottomBarController.index.value]),
    );
  }
}
