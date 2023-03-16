import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp_firebase/model/chat_model.dart';
import 'package:chatapp_firebase/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<ChatModel> chatList = [];
  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile Screen"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.width * 0.06,
            vertical: mediaQuery.height * 0.03),
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(mediaQuery.height * .5),
            child: CachedNetworkImage(
              height: mediaQuery.height * .2,
              width: mediaQuery.width * .5,
              imageUrl:
                  "https://wallpapers.com/images/featured/s52z1uggme5sj92d.jpg",
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          SizedBox(
            height: mediaQuery.height * 0.05,
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: "eg. hirakiran",
                prefixIcon: const Icon(CupertinoIcons.person),
                border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(mediaQuery.height * 0.02))),
          ),
          SizedBox(
            height: mediaQuery.height * 0.02,
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: "About",
                prefixIcon: const Icon(CupertinoIcons.info_circle),
                border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(mediaQuery.height * 0.02))),
          ),
          SizedBox(
            height: mediaQuery.height * 0.05,
          ),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueColor,
                  shape: const StadiumBorder(),
                  minimumSize:
                      Size(mediaQuery.width * 0.9, mediaQuery.height * 0.06)),
              onPressed: () {},
              icon: const Icon(Icons.update),
              label: const Text("Update"))
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.redColor,
          label: const Text("Logout"),
          onPressed: () {},
          icon: const Icon(Icons.logout)),
    );
  }
}
