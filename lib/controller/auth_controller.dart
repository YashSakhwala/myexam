// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_const_constructors, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myexam/config/local_storage.dart';
import 'package:myexam/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:myexam/widgets/common_widget/indicator_view.dart';
import 'package:myexam/widgets/common_widget/toast_view.dart';

class AuthController extends GetxController {
  final RxBool isLoginPasswordShow = true.obs;
  final RxBool isSignUpPasswordShow = true.obs;
  final RxBool isVerifyPasswordShow = true.obs;
  final RxString imagePath = "".obs;

  Future<void> LogIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      indicatorView(context);

      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      print(userCredential.user!.uid);

      await LocalStorage.sharedPreferences.setBool(LocalStorage.logIn, true);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BottomBarScreen(),
      ));
    } catch (e) {
      toastView(msg: "Email or password is incorrect");
      Navigator.of(context).pop();
    }
  }

  Future<void> SignUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      indicatorView(context);

      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      final UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      print(userCredential.user!.uid);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BottomBarScreen(),
      ));
    } catch (e) {
      toastView(msg: "User is already exist");
      Navigator.of(context).pop();
    }
  }
}
