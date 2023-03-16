import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../servicess/signin_with_google.dart';
import '../utills/routes/routes_names.dart';
import '../utills/utills.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              GoogleSigninClass().signOutGoogle().then((value) {
                Navigator.pop(context);
                Utills().toastMethod("Logout Successfully");

                Navigator.pushNamed(context, RoutesNames.loginScreen);
                log(value!.user.toString());
              }).onError((error, stackTrace) {
                Utills().toastMethod(error.toString());
              });
            },
            icon: const Icon(Icons.logout)),
        centerTitle: true,
        title: const Text("Chat App"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {}, child: const Icon(Icons.add_comment_rounded)),
    );
  }
}
