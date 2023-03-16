// ignore_for_file: file_names

import 'package:chatapp_firebase/main.dart';
import 'package:chatapp_firebase/res/colors.dart';
import 'package:chatapp_firebase/res/images.dart';
import 'package:flutter/material.dart';

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
        Container(
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
              InkWell(
                onTap: (){},
                child: const Text(
                  "Continue with Google",
                  style: TextStyle(),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}