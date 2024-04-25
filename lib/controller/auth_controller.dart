// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_const_constructors, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myexam/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:myexam/widgets/common_widget/indicator_view.dart';

class AuthController extends GetxController {
  RxBool isLoginPasswordShow = true.obs;
  RxBool isSignUpPasswordShow = true.obs;
  RxBool isVerifyPasswordShow = true.obs;

  Future<void> logIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    indicatorView(context);

    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    final UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    print(userCredential.user!.uid);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BottomBarScreen(),
    ));
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    indicatorView(context);

    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    final UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    print(userCredential.user!.uid);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BottomBarScreen(),
    ));
  }
}
