import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp_firebase/main.dart';
import 'package:chatapp_firebase/model/chat_model.dart';
import 'package:chatapp_firebase/res/colors.dart';
import 'package:flutter/material.dart';

class ChatCardW extends StatelessWidget {
  final ChatModel user;
  const ChatCardW({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context).size;
    return Card(
      margin:
          EdgeInsets.symmetric(horizontal: mediaQuery.width * .04, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        onTap: () {},
        title: Text(user.name),
        subtitle: Text(user.about),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(mediaQuery.height * .3),
          child: CachedNetworkImage(
            height: mediaQuery.height * .12,
            width: mediaQuery.width * .15,
            imageUrl: user.image,
            fit: BoxFit.fill,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        /* leading: const CircleAvatar(
          child: Icon(CupertinoIcons.person),
        ), */
        trailing: Text(
          "12:00 PM",
          style: TextStyle(color: AppColors.lightBlack),
        ),
      ),
    );
  }
}
