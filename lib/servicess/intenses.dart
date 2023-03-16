import 'package:chatapp_firebase/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Instanses {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static get user => auth.currentUser!;

  static Future<bool> userExists() async {
    return (await firestore.collection("users").doc().get()).exists;
  }

  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatModel = ChatModel(
        image: user.image.toString(),
        about: user.about,
        name: user.name.toString(),
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
}
