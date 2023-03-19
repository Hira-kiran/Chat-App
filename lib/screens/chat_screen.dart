import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp_firebase/main.dart';
import 'package:chatapp_firebase/model/chat_model.dart';
import 'package:chatapp_firebase/model/message_model.dart';
import 'package:chatapp_firebase/res/colors.dart';
import 'package:flutter/material.dart';

import '../servicess/intenses.dart';
import '../widgets/message_card.dart';

class ChatScreen extends StatefulWidget {
  final ChatModel user;
  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // for storing messages
  List<MessageDataModel> messageList = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          flexibleSpace: _appbar(),
          // title: const Text("Chat Screen"),
        ),
        body: Column(children: [
          Expanded(
            child: StreamBuilder(
                stream: Instanses.getMessages(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    // return const Center(child: CircularProgressIndicator());
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;
                      log("data ${jsonEncode(data![0].data())}");
                      // log("Data ${jsonEncode(data![0].data())}");
                      /*  _chatList =
                          data.map((e) => ChatModel.fromJson(e.data())).toList(); */

                      if (messageList.isNotEmpty) {
                        return ListView.builder(
                            itemCount: messageList.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return MessageCardW(
                                message: messageList[index],
                              );
                            });
                      } else {
                        return const Center(child: Text("Say Hii! 👋"));
                      }
                  }
                }),
          ),
          _chatInput()
        ]),
      ),
    );
  }

  Widget _appbar() {
    return InkWell(
      onTap: () {},
      child: Row(children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        ClipRRect(
          borderRadius: BorderRadius.circular(mediaQuery.height * .03),
          child: CachedNetworkImage(
            height: mediaQuery.height * .05,
            width: mediaQuery.width * .11,
            imageUrl: widget.user.image,
            fit: BoxFit.fill,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        SizedBox(width: mediaQuery.width * 0.04),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.user.name,
              style: TextStyle(color: AppColors.whileColor, fontSize: 18),
            ),
            Text(widget.user.about,
                style: TextStyle(color: AppColors.whileColor)),
          ],
        )
      ]),
    );
  }

  Widget _chatInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.emoji_emotions,
                        color: AppColors.blueColor,
                      )),
                  Expanded(
                      child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                        hintText: "Message", border: InputBorder.none),
                  )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.image,
                        color: AppColors.blueColor,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera_alt_rounded,
                        color: AppColors.blueColor,
                      )),
                ],
              ),
            ),
          ),
          MaterialButton(
            shape: const CircleBorder(),
            minWidth: 0,
            padding:
                const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 5),
            color: AppColors.blueColor,
            onPressed: () {},
            child: Icon(
              Icons.send,
              color: AppColors.whileColor,
            ),
          )
        ],
      ),
    );
  }
}
