import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  Future<void> logIn({
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
      toastView(msg: "Email or password incorrect");

      Navigator.of(context).pop();
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String phoneNo,
    required BuildContext context,
  }) async {
    try {
      indicatorView(context);

      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      final UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      print(userCredential.user!.uid);

      FirebaseStorage firebaseStorage = FirebaseStorage.instance;

      String url = "";

      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      String ImageExt = imagePath.value.split("/").last.split(".").last;

      Reference reference = firebaseStorage.ref("$imageName.$ImageExt");

      UploadTask uploadTask = reference.putFile(File(imagePath.value));

      TaskSnapshot taskSnapshot = await uploadTask;
      if (taskSnapshot.state == TaskState.success) {
        url = await reference.getDownloadURL();
      } else {
        toastView(msg: "File doesn't upload");
      }

      // String url = await reference.getDownloadURL();

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore
          .collection("Teacher")
          .doc(userCredential.user!.uid)
          .set({
        "email": email,
        "phoneNo": phoneNo,
        "image": url,
      });

      await LocalStorage.sharedPreferences.setBool(LocalStorage.logIn, true);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BottomBarScreen(),
      ));
    } catch (e) {
      toastView(msg: "User is already exist");

      Navigator.of(context).pop();
    }
  }
}
