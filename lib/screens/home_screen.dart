import 'dart:developer';
import 'package:chatapp_firebase/model/chat_model.dart';
import 'package:chatapp_firebase/res/colors.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../servicess/intenses.dart';
import '../servicess/signin_with_google.dart';
import '../utills/routes/routes_names.dart';
import '../utills/utills.dart';
import '../widgets/chat_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatModel> chatList = [];
  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context).size;
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
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesNames.profileScreen);
              },
              icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: StreamBuilder(
          stream: Instanses.firestore.collection("users").snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data!.docs;
                chatList =
                    data.map((e) => ChatModel.fromJson(e.data())).toList();
                if (chatList.isNotEmpty) {
                  return ListView.builder(
                      itemCount: chatList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ChatCardW(user: chatList[index]);
                      });
                } else {
                  return const Center(child: Text("NO Connection Found!"));
                }
            }
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.blueColor,
          onPressed: () {},
          child: const Icon(Icons.add_comment_rounded)),
    );
  }
}
