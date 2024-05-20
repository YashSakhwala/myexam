// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myexam/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LocalStorage.sharedPreferences = await SharedPreferences.getInstance();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
