// ignore_for_file: file_names

import 'dart:developer';
import 'package:chatapp_firebase/main.dart';
import 'package:chatapp_firebase/res/colors.dart';
import 'package:chatapp_firebase/res/images.dart';
import 'package:chatapp_firebase/servicess/intenses.dart';
import 'package:chatapp_firebase/utills/routes/routes_names.dart';
import 'package:chatapp_firebase/utills/utills.dart';
import 'package:flutter/material.dart';

import '../servicess/signin_with_google.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Login Screen"),
      ),
      body: Column(children: [
        Center(
          child: Image.asset(
            Appimages.chatImg,
            height: mediaQuery.height * 0.3,
            width: mediaQuery.height * 0.3,
          ),
        ),
        SizedBox(
          height: mediaQuery.height * 0.4,
        ),
        InkWell(
          onTap: () {
            Utills.progressBar(context);
            GoogleSigninClass().signInWithGoogle(context).then((value) async {
              Navigator.pop(context);
              Utills().toastMethod("Login Successfully");
              if ((await Instanses.existsUser())) {
                Navigator.pushNamed(context, RoutesNames.homeScreen);
              } else {
                await Instanses.createUser().then((value) {
                  Navigator.pushNamed(context, RoutesNames.homeScreen);
                });
              }

              log(value!.user.toString());
            }).onError((error, stackTrace) {
              Navigator.pop(context);
              Utills().toastMethod(error.toString());
            });
          },
          child: Container(
            width: mediaQuery.width * 0.85,
            height: mediaQuery.height * 0.07,
            decoration: BoxDecoration(
              color: AppColors.lightGreyColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: mediaQuery.width * 0.02,
                ),
                SizedBox(
                  width: mediaQuery.width * 0.1,
                  height: mediaQuery.height * 0.05,
                  child: Image.asset(
                    Appimages.googleImg,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: mediaQuery.width * 0.1,
                ),
                const Text(
                  "Continue with Google",
                  style: TextStyle(),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
