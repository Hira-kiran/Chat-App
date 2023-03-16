import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utills {
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

  static void snackbarrMethod(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  static void progressBar(BuildContext context) {
    showDialog(
        context: context, builder: (context) => const Center(child: CircularProgressIndicator()));
  }
}
