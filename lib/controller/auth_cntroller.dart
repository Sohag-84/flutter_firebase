// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/routes/route.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  final box = GetStorage();
  final _otpController = TextEditingController();

  Future signUp(email, password) async {
    try {
      final auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var authCredential = userCredential.user;
      print(authCredential);

      if (authCredential!.uid.isNotEmpty) {
        box.write('id', authCredential.uid);
        Get.toNamed(homeScreen);
      } else {
        print("sign up fail");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        print("The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }

  Future signIn(email, password) async {
    try {
      final auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var authCredential = userCredential.user;

      print(authCredential!.uid);
      print(authCredential);

      if (authCredential.uid.isNotEmpty) {
        box.write('id', authCredential.uid); //for store local database
        Get.toNamed(homeScreen);
      } else {
        print("sign up fail");
      }
    } catch (e) {
      print(e);
    }
  }

  static Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = userCredential.user;
    if (user!.uid.isNotEmpty) {
      Get.toNamed(homeScreen);
    } else {
      print("Something is wrong!");
    }
  }

  Future phoneAuth(number) async {
    final auth = FirebaseAuth.instance;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        final userCredential = await auth.signInWithCredential(credential);

        User? _user = userCredential.user;
        if (_user!.uid.isNotEmpty) {
          Get.toNamed(homeScreen);
        } else {
          print('failed');
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        Get.defaultDialog(
          content: Column(
            children: [
              TextField(
                controller: _otpController,
              ),
              SizedBox(height: 15),
              InkWell(
                onTap: () async {
                  PhoneAuthCredential _phoneAuthCredention =
                      PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: _otpController.text,
                  );
                  final userCredential =
                      await auth.signInWithCredential(_phoneAuthCredention);

                  User? _user = userCredential.user;
                  if (_user!.uid.isNotEmpty) {
                    Get.toNamed(homeScreen);
                  } else {
                    print('failed');
                  }
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
                      "Continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
