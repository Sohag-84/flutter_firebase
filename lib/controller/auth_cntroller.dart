// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/routes/route.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  final box = GetStorage();

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

  static Future signOut() async {
    await FirebaseAuth.instance.signOut();
    //Get.toNamed(signinScreen);
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
}
