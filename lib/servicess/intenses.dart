import 'dart:developer';
import 'dart:io';
import 'package:chatapp_firebase/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Instanses {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  // for accessing  firebase sto
  static FirebaseStorage firestoreStorage = FirebaseStorage.instance;
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

//********************** for updating picture of user *****************
  static Future<void> updateProfilePic(File file) async {
    // getting image file extension
    final extension = file.path.split(".").last;
    log("Extension: $extension");

    final ref =
        firestoreStorage.ref().child("profile_pictures/${user.uid}.$extension");
    // uploading image

    await ref
        .putFile(file, SettableMetadata(contentType: "image/$extension"))
        .then((p0) {
      log("Data Transferred:${p0.bytesTransferred / 1000} kb");
    });

    // uploading image in firestore database
    me.image = await ref.getDownloadURL();
    await firestore
        .collection("users")
        .doc(user.uid)
        .update({"image": me.image});
  }

// get  all messages of specific conversation on firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMessages() {
    return firestore.collection("messages").snapshots();
  }
}
