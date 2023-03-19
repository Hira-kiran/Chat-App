// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'package:chatapp_firebase/res/images.dart';
import 'package:chatapp_firebase/utills/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../servicess/intenses.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.edgeToEdge); // exit full screen
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor:
              Colors.transparent)); // style the status bar

      if (Instanses.auth != null) {
        Navigator.pushNamed(context, RoutesNames.homeScreen);
      } else {
        Navigator.pushNamed(context, RoutesNames.loginScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Center(child: Image.asset(Appimages.chatImg))]),
    );
  }
}
