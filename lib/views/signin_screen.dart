// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_firebase/controller/auth_cntroller.dart';
import 'package:get/get.dart';

import '../routes/route.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 40.0),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Enter your email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _passwordController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: "Enter your password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 35),
              InkWell(
                onTap: () {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  final authHelper = AuthHelper();
                  authHelper.signIn(email, password);
                },
                child: Container(
                  width: double.infinity,
                  height: 53,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () => Get.toNamed(signupScreen),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      " Signup",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
