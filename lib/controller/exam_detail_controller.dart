import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myexam/widgets/common_widget/toast_view.dart';

class ExamDetailController extends GetxController {
  RxList examData = [].obs;
  final RxMap examDetail = {}.obs;

  Future<void> getExam({
    required int code,
    required BuildContext context,
  }) async {
    try {
      // indicatorView(context);

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var data = await firebaseFirestore
          .collection("Exams")
          .doc(code.toString())
          .get();

      examData.assignAll([data.data()]);

      examDetail.value = data.data() ?? {};

      print(examDetail);
    } catch (e) {
      toastView(msg: "Details can't fetch");

      Navigator.of(context).pop();
    }
  }

  Future<void> getExamDetail() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore.collection("Exams");
  }
}
