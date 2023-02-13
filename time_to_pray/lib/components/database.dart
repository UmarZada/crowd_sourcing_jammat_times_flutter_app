import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:time_to_pray/global/global.dart';
import 'package:time_to_pray/splash_screen.dart';

import '../model/user_model.dart';

class Database {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<String> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String contactNo,
    required String password,
    required String cnic,
    required String status,
  }) async {
    String res = "some thing went wrong";
    try {
      if (email.isNotEmpty ||
          name.isNotEmpty ||
          contactNo.isNotEmpty ||
          password.isNotEmpty ||
          cnic.isNotEmpty ||
          status.isNotEmpty) {
        UserCredential credential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);

        UserModel userModel = UserModel(
          name: name,
          contactNo: contactNo,
          email: email,
          cnic: cnic,
          status: status,
          userId: credential.user!.uid,
        );
        firebaseFirestore
            .collection("users")
            .doc(credential.user!.uid)
            .set(userModel.toJson());
        res = "success";
      } else {
        res = "Please Enter all the fields";
      }
    } on FirebaseException catch (e) {
      if (e.code == "invalid-email") {
        res = "The email is badly formated.";
      } else if (e.code == "weak-password") {
        res = "Yor password is too weak";
      }
    } catch (error) {
      res = error.toString();
    }

    return res;
  }

  Future<String> login(String email, String password) async {
    String res = "something went wrong";
    User? currentUser;
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((data) => {
                  currentUser = data.user!,
                });
        if (currentUser != null) {
          res = "success";
        } else {
          res = "No record found";
          firebaseAuth.signOut();
        }
      } else {
        res = "Please enter required Fields";
      }
    } on FirebaseException catch (e) {
      if (e.code == 'wrong-password') {
        res = "Incorrect Password";
      } else {
        res = e.toString();
      }
    }
    return res;
  }

  void logout(BuildContext context) async {
    firebaseAuth.signOut();
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Splash()));
  }
}
