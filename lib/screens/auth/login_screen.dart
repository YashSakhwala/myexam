// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myexam/config/app_colors.dart';
import 'package:myexam/config/app_image.dart';
import 'package:myexam/config/app_style.dart';
import 'package:myexam/controller/auth_controller.dart';
import 'package:myexam/screens/auth/sign_up_screen.dart';
import 'package:myexam/screens/welcome/welcome_screen.dart';
import 'package:myexam/widgets/common_widget/button_view.dart';
import 'package:myexam/widgets/common_widget/indicator_view.dart';
import 'package:myexam/widgets/common_widget/text_field_view.dart';
import 'package:myexam/widgets/common_widget/toast_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController = Get.put(AuthController());

  final GlobalKey<FormState> _formkey = GlobalKey();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: ListView(
            children: [
              SizedBox(
                height: 90,
              ),
              Text(
                "Welcome Back",
                style: AppTextStyle.largeTextStyle.copyWith(
                  fontSize: 37,
                ),
              ),
              Text(
                "Sign in to continue",
                style: AppTextStyle.smallTextStyle.copyWith(
                  color: AppColors.blackThemeBoxColor,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextFieldView(
                labelText: "Email",
                controller: email,
                needValidator: true,
                emailValidator: true,
              ),
              SizedBox(
                height: 5,
              ),
              Obx(
                () => TextFieldView(
                  labelText: "Password",
                  controller: password,
                  obscureText: authController.isLoginPasswordShow.value,
                  needValidator: true,
                  passwordValidator: true,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      authController.isLoginPasswordShow.value =
                          !authController.isLoginPasswordShow.value;
                    },
                    child: Image.asset(
                      authController.isLoginPasswordShow.value == true
                          ? AppImages.openEye
                          : AppImages.closeEye,
                      scale: 20,
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  if (RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(email.text)) {
                    indicatorView(context);

                    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

                    await firebaseAuth.sendPasswordResetEmail(
                      email: email.text,
                    );

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen(),
                        ),
                        (route) => false);
                  } else {
                    toastView(msg: "Please enter valid email");
                  }
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Forgot password?",
                    style: AppTextStyle.smallTextStyle.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              ButtonView(
                title: "Sign in",
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    authController.logIn(
                      email: email.text,
                      password: password.text,
                      context: context,
                    );
                  }
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't have an account? ",
                        style: AppTextStyle.smallTextStyle.copyWith(
                          fontSize: 13,
                          color: AppColors.greyColor,
                        ),
                      ),
                      TextSpan(
                        text: "Create Now",
                        style: AppTextStyle.smallTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
