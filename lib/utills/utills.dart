// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:chatapp_firebase/main.dart';
import 'package:chatapp_firebase/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Utills {
  // for Toast Message
  toastMethod(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // for Snackbar
  static void snackbarrMethod(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

// for dialogue box
  static void progressBar(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));
  }


 
}
