// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myexam/controller/auth_controller.dart';
import 'package:myexam/screens/auth/login_screen.dart';
import 'package:myexam/widgets/common_widget/toast_view.dart';
import '../../config/app_colors.dart';
import '../../config/app_image.dart';
import '../../config/app_style.dart';
import '../../widgets/common_widget/button_view.dart';
import '../../widgets/common_widget/text_field_view.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthController authController = Get.put(AuthController());

  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController verifyPassword = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey();

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
                height: 20,
              ),
              Text(
                "Create Account",
                style: AppTextStyle.largeTextStyle.copyWith(
                  fontSize: 37,
                ),
              ),
              Text(
                "Create an account to continue",
                style: AppTextStyle.smallTextStyle.copyWith(
                  fontSize: 14,
                  color: AppColors.blackThemeBoxColor,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () async {
                  ImagePicker imagePicker = ImagePicker();

                  XFile? xFile =
                      await imagePicker.pickImage(source: ImageSource.gallery);

                  authController.imagePath.value = xFile!.path;
                },
                child: Stack(
                  children: [
                    Obx(
                      () => Container(
                        height: 82,
                        width: 82,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor),
                          color: AppColors.whiteColor,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: authController.imagePath.value.isEmpty
                                ? Image.asset(
                                    AppImages.fillProfile,
                                    scale: 12,
                                  ).image
                                : Image.file(
                                        File(authController.imagePath.value))
                                    .image,
                            fit: authController.imagePath.value.isEmpty
                                ? BoxFit.none
                                : BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 58,
                      child: Container(
                        height: 23,
                        width: 23,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                        child: Icon(
                          Icons.add,
                          size: 17,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
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
              TextFieldView(
                labelText: "Phone No",
                controller: phoneNo,
                keyboardType: TextInputType.phone,
                needValidator: true,
                phoneNoValidator: true,
              ),
              SizedBox(
                height: 5,
              ),
              Obx(
                () => TextFieldView(
                  labelText: "Password",
                  controller: password,
                  obscureText: authController.isSignUpPasswordShow.value,
                  needValidator: true,
                  passwordValidator: true,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      authController.isSignUpPasswordShow.value =
                          !authController.isSignUpPasswordShow.value;
                    },
                    child: Image.asset(
                      authController.isSignUpPasswordShow.value == true
                          ? AppImages.openEye
                          : AppImages.closeEye,
                      scale: 20,
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Obx(
                () => TextFieldView(
                  labelText: "Verify Password",
                  controller: verifyPassword,
                  obscureText: authController.isVerifyPasswordShow.value,
                  needValidator: true,
                  passwordValidator: true,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      authController.isVerifyPasswordShow.value =
                          !authController.isVerifyPasswordShow.value;
                    },
                    child: Image.asset(
                      authController.isVerifyPasswordShow.value == true
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
              Text(
                "You can make changes in the profile",
                style: AppTextStyle.smallTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                height: 80,
              ),
              ButtonView(
                title: "Continue",
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    if (password.text != verifyPassword.text) {
                      toastView(msg: "Both passwords are not same");
                    } else if (authController.imagePath.value.isEmpty) {
                      toastView(msg: "Please select profile image");
                    } else {
                      authController.signUp(
                        email: email.text,
                        password: password.text,
                        phoneNo: phoneNo.text,
                        context: context,
                      );
                    }
                  }
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Already have an account? ",
                        style: AppTextStyle.smallTextStyle.copyWith(
                          fontSize: 13,
                          color: AppColors.greyColor,
                        ),
                      ),
                      TextSpan(
                        text: "Sign In",
                        style: AppTextStyle.smallTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
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
