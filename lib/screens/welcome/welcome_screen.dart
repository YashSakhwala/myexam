// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myexam/config/app_colors.dart';
import 'package:myexam/config/app_image.dart';
import 'package:myexam/config/app_style.dart';
import 'package:myexam/screens/auth/login_screen.dart';
import 'package:myexam/screens/auth/sign_up_screen.dart';
import 'package:myexam/widgets/common_widget/button_view.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Image.asset(
              AppImages.welcome,
              height: 230,
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                "Welcome to our educational platform, where learning meets innovation",
                textAlign: TextAlign.center,
                style: AppTextStyle.regularTextStyle.copyWith(
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ButtonView(
              title: "Sign in",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
              },
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Already have an account?",
                style: AppTextStyle.smallTextStyle.copyWith(
                  fontSize: 14,
                  color: AppColors.greyColor,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonView(
              title: "Create account",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SignUpScreen(),
                ));
              },
              containerColor: AppColors.primaryColor.withOpacity(0.07),
              titleColor: AppColors.primaryColor,
            ),
            SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "By creating an account, you are agreeing to our\n",
                      style: AppTextStyle.smallTextStyle.copyWith(
                        fontSize: 13,
                        color: AppColors.greyColor,
                      ),
                    ),
                    TextSpan(
                      text: "Terms and Service",
                      style: AppTextStyle.smallTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          final Uri _url = Uri.parse(
                              "https://doc-hosting.flycricket.io/quiz-up-terms-of-use/65b0b200-860c-426e-b052-b3336c078a75/terms");

                          if (!await launchUrl(_url)) {
                            throw Exception("Could not launch $_url");
                          }
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
