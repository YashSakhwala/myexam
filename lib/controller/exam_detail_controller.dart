// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myexam/screens/marks/marks_screen.dart';
import 'package:myexam/widgets/common_widget/toast_view.dart';
import '../config/local_storage.dart';
import '../screens/history_marks/history_marks_screen.dart';
import '../widgets/common_widget/indicator_view.dart';

class ExamDetailController extends GetxController {
  RxList examCodeList = [].obs;
  RxList examData = [].obs;

  RxBool isLoader = true.obs;

  RxList homeScreenExam = [].obs;
  RxList historyScreenExam = [].obs;

  RxMap examResult = {}.obs;

  RxList studentData = [].obs;

  Future<void> getExam({
    required BuildContext context,
  }) async {
    isLoader.value = true;

    examData.clear();
    homeScreenExam.clear();
    historyScreenExam.clear();

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    String? userId =
        LocalStorage.sharedPreferences.getString(LocalStorage.userId);

    var data = await firebaseFirestore.collection("Student").doc(userId).get();

    Map? temp = {};
    temp = data.data();

    examCodeList.value = temp!["examCode"];

    for (String code in examCodeList) {
      var data =
          await FirebaseFirestore.instance.collection("Exams").doc(code).get();

      examData.add(data.data());

      print(examData);
    }

    for (int i = 0; i < examData.length; i++) {
      bool isCheck = checkDateAndTime(
        enteredDate: examData[i]["date"],
        enteredTime: examData[i]["time"],
        duration: examData[i]["examDuration"],
        context: context,
      );

      if (isCheck) {
        var data = await firebaseFirestore
            .collection("Exams")
            .doc(examData[i]["code"].toString())
            .collection("Answer")
            .doc(userId)
            .get();
        var temp = data.data();
        if (temp != null) {
          historyScreenExam.add(examData[i]);
        } else {
          homeScreenExam.add(examData[i]);
        }
      } else {
        historyScreenExam.add(examData[i]);
      }
    }

    isLoader.value = false;
  }

  bool checkDateAndTime({
    required String enteredDate,
    required String enteredTime,
    required String duration,
    required BuildContext context,
  }) {
    List<String> dateParts = enteredDate.split('-');
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);

    List<String> timeParts = enteredTime.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1].split(' ')[0]);
    String period = timeParts[1].split(' ')[1];

    if (period == 'PM' && hour != 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0;
    }

    DateTime givenDateTime = DateTime(year, month, day, hour, minute);

    Duration durationToAdd = parseDuration(duration);
    DateTime finalDateTime = givenDateTime.add(durationToAdd);
    DateTime currentDateTime = DateTime.now();

    if (currentDateTime.isBefore(finalDateTime)) {
      return true;
    } else {
      return false;
    }
  }

  Duration parseDuration(String duration) {
    List<String> parts = duration.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    return Duration(hours: hours, minutes: minutes);
  }

  Future<void> addExamCode({
    required String examCode,
    required BuildContext context,
  }) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    var data = await firebaseFirestore.collection("Exams").doc(examCode).get();

    Map? temp = {};
    temp = data.data();

    if (temp == null || temp.isEmpty) {
      toastView(msg: "Enter valid exam code");
    } else {
      String? userId =
          LocalStorage.sharedPreferences.getString(LocalStorage.userId);

      List codeData = [];
      codeData = examCodeList;

      codeData.add(examCode);

      await firebaseFirestore.collection("Student").doc(userId).update({
        "examCode": codeData,
      });

      await getExam(context: context);
    }
  }

  Future<void> addQuestion({
    required Map questionList,
    required int rightQuestion,
    required BuildContext context,
  }) async {
    indicatorView(context);

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    var code = questionList["code"];
    String? userId =
        LocalStorage.sharedPreferences.getString(LocalStorage.userId);

    var data = await firebaseFirestore.collection("Student").doc(userId).get();
    var studentData = data.data();
    var name = studentData!["name"];
    var image = studentData["image"];

    var totalQuestions = questionList["questions"].length;
    var rightQuestions = rightQuestion;

    var percentage = (rightQuestions / totalQuestions * 100);
    String tempPercentage = percentage.toStringAsFixed(2);

    var questionsList = questionList;

    await firebaseFirestore
        .collection("Exams")
        .doc(code.toString())
        .collection("Answer")
        .doc(userId)
        .set({
      "total": totalQuestions,
      "right": rightQuestions,
      "percentage": tempPercentage,
      "answer": questionList["questions"],
      "name": name,
      "image": image,
    });

    var stud = await firebaseFirestore.collection("Student").doc(userId).get();

    var temp = stud.data();

    double changeDouble = double.parse(temp!["percentage"]);
    var totalPerecentage = (changeDouble + percentage) / 2;
    String tempTotalPercentage = totalPerecentage.toStringAsFixed(2);

    await firebaseFirestore.collection("Student").doc(userId).update({
      "percentage": tempTotalPercentage,
    });

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MarksScreen(
            questionsList: questionsList,
            rightQuestions: rightQuestions,
            percentage: double.parse(tempPercentage),
          ),
        ));
  }

  Future<void> getQuestion({
    required String code,
    required String examDuration,
    required BuildContext context,
  }) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    String? userId =
        LocalStorage.sharedPreferences.getString(LocalStorage.userId);

    var data = await firebaseFirestore
        .collection("Exams")
        .doc(code)
        .collection("Answer")
        .doc(userId)
        .get();

    examResult.value = data.data()!;

    print(examResult);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => HistoryMarksScreen(
        examDuration: examDuration,
      ),
    ));
  }

  Future<void> getStudentData() async {
    isLoader.value = true;

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    var data = await firebaseFirestore.collection("Student").get();

    studentData.value = data.docs.map((doc) => doc.data()).toList();

    studentData.value = studentData.toList()
      ..sort((a, b) => b["percentage"].compareTo(a["percentage"]));

    isLoader.value = false;
  }
}
