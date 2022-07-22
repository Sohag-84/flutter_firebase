// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';

import '../views/home_screen.dart';
import '../views/phone_auth_screen.dart';
import '../views/signin_screen.dart';
import '../views/signup_screen.dart';
import '../views/splash_screen.dart';

const String splashScreen = '/splash-screen';
const String signupScreen = '/signup-screen';
const String signinScreen = '/signin-screen';
const String homeScreen = '/home-screen';
const String phoneAuthScreen = '/phoneAuth-screen';

List<GetPage> pages = [
  GetPage(name: splashScreen, page: () => SplashScreen()),
  GetPage(name: signupScreen, page: () => SignUpScreen()),
  GetPage(name: signinScreen, page: () => SigninScreen()),
  GetPage(name: homeScreen, page: () => HomeScreen()),
  GetPage(name: phoneAuthScreen, page: () => PhoneAuthScreen()),
];
