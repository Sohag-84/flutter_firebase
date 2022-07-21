// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_firebase/routes/route.dart';
import 'package:flutter_firebase/views/home_screen.dart';
import 'package:flutter_firebase/views/signin_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final box = GetStorage();
  chooseScreen() async {
    var userid = await box.read('id');
    if (userid != null) {
      Get.offAllNamed(homeScreen);
    } else {
      Get.offAllNamed(signinScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () => chooseScreen());
    return Scaffold(
      body: Center(child: CircleAvatar()),
    );
  }
}
