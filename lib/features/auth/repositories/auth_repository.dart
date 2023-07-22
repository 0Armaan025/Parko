import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:parko/common/constants/constants.dart';
import 'package:parko/common/constants/utils.dart';
import 'package:parko/common/progress_dialog.dart';
import 'package:parko/features/auth/models/user.dart';
import 'package:parko/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  /// sign up function

  void signUp(BuildContext context, UserModel model) async {
    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: model.email, password: model.password)
        .then((value) {
      // add a function to store images to supabase

      // will do on 19/7/2023

      //add data to firestore

      String uid = firebaseAuth.currentUser?.uid ?? '';

      UserModel newModel = UserModel(
          name: model.name,
          uid: uid,
          email: model.email,
          profilePicture: '',
          password: model.password);

      firestore
          .collection('users')
          .doc(uid)
          .set(newModel.toMap())
          .then((value) {
        showSnackBar(
          context,
          "Successful!",
          "Hey, it's successful!",
          ContentType.success,
        );
        moveScreen(context, const HomeScreen());
      });
    });
  }

  void logIn(BuildContext context, String email, String pass) async {
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              ProgressDialog(message: 'Signing You In Please Wait..'));
      showSnackBar(
        context,
        "Successful!",
        "Hey, it's successful!",
        ContentType.success,
      );
      moveScreen(context, const HomeScreen());
    });
  }
}
