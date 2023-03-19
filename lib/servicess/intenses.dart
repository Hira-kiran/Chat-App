import 'dart:developer';
import 'package:chatapp_firebase/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Instanses {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  // to return current user
  static User get user => auth.currentUser!;
  // for storing self info
  static late ChatModel me;

// for getting current user info
  static Future<void> getSelfInfo() async {
    await firestore.collection("users").doc(user.uid).get().then((value) async {
      if (value.exists) {
        me = ChatModel.fromJson(value.data()!);
        log("My Data ${value.data()}");
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

// for checking te user is exists or not
  static Future<bool> existsUser() async {
    return (await firestore.collection("users").doc(user.uid).get()).exists;
  }

// For creating new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatModel = ChatModel(
        id: user.uid,
        image: user.photoURL.toString(),
        about: "Busy",
        name: user.displayName.toString(),
        lastActive: time,
        isOnline: false,
        creatingAt: time,
        pushToken: "",
        email: user.email.toString());
    return await firestore
        .collection("users")
        .doc(user.uid)
        .set(chatModel.toJson());
  }

// for getting all the users from firebase database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection("users")
        .where("id", isNotEqualTo: user.uid)
        .snapshots();
  }

  static Future<void> updateUserInfo() async {
    await firestore
        .collection("users")
        .doc(user.uid)
        .update({"name": me.name, "about": me.about});
  }
}
