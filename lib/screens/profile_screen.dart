// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp_firebase/model/chat_model.dart';
import 'package:chatapp_firebase/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../main.dart';
import '../servicess/intenses.dart';
import '../servicess/signin_with_google.dart';
import '../utills/routes/routes_names.dart';
import '../utills/utills.dart';

class ProfileScreen extends StatefulWidget {
  final ChatModel user;
  const ProfileScreen({
    super.key,
    required this.user,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String? _img;
  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context).size;
    return GestureDetector(
      // for hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Profile Screen"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.width * 0.06,
                vertical: mediaQuery.height * 0.03),
            child: Column(children: [
              Stack(
                children: [
                  _img != null
                      ? ClipRRect(
                          borderRadius:
                              BorderRadius.circular(mediaQuery.height * .5),
                          child: Image.file(
                            File(_img!),
                            height: mediaQuery.height * .2,
                            width: mediaQuery.width * .5,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipRRect(
                          borderRadius:
                              BorderRadius.circular(mediaQuery.height * .5),
                          child: CachedNetworkImage(
                            height: mediaQuery.height * .2,
                            width: mediaQuery.width * .5,
                            imageUrl: widget.user.image,
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: MaterialButton(
                      shape: const CircleBorder(),
                      color: AppColors.whileColor,
                      onPressed: () {
                        bottomSheet();
                      },
                      child: Icon(
                        Icons.edit,
                        color: AppColors.blueColor,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: mediaQuery.height * 0.02,
              ),
              Text(
                widget.user.email,
                style: TextStyle(fontSize: 18, color: AppColors.lightBlack),
              ),
              SizedBox(
                height: mediaQuery.height * 0.02,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: widget.user.email,
                      decoration: InputDecoration(
                          hintText: "eg. hirakiran",
                          prefixIcon: const Icon(CupertinoIcons.person),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  mediaQuery.height * 0.02))),
                      onSaved: (newValue) => Instanses.me.name = newValue ?? "",
                      validator: (value) => value != null && value.isNotEmpty
                          ? null
                          : " Enter Name",
                    ),
                    SizedBox(
                      height: mediaQuery.height * 0.02,
                    ),
                    TextFormField(
                      initialValue: widget.user.about,
                      decoration: InputDecoration(
                          hintText: "About",
                          prefixIcon: const Icon(CupertinoIcons.info_circle),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  mediaQuery.height * 0.02))),
                      onSaved: (newValue) =>
                          Instanses.me.about = newValue ?? "",
                      validator: (value) => value != null && value.isNotEmpty
                          ? null
                          : " Enter Name",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: mediaQuery.height * 0.05,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueColor,
                      shape: const StadiumBorder(),
                      minimumSize: Size(
                          mediaQuery.width * 0.9, mediaQuery.height * 0.06)),
                  onPressed: () {
                    setState(() {
                      loading = true;
                    });
                    if (_formKey.currentState!.validate()) {
                      log("valid");
                      _formKey.currentState!.save();
                      Instanses.updateUserInfo().then((value) {
                        setState(() {
                          loading = false;
                        });
                        Utills().toastMethod("Profile Updated Successfully");
                      }).onError((error, stackTrace) {
                        setState(() {
                          loading = false;
                        });
                        Utills().toastMethod(error.toString());
                      });
                    }
                  },
                  icon: const Icon(Icons.update),
                  label: loading == true
                      ? CircularProgressIndicator(
                          color: AppColors.whileColor,
                        )
                      : const Text("Update"))
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AppColors.redColor,
            label: const Text("Logout"),
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
      ),
    );
  }

  // for bottom sheet
  void bottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (context) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                top: mediaQuery.height * 0.02,
                bottom: mediaQuery.height * 0.02),
            children: [
              const Text(
                textAlign: TextAlign.center,
                "Pick Profile Picture",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: mediaQuery.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          fixedSize: Size(
                              mediaQuery.width * 0.3, mediaQuery.height * 0.15),
                          backgroundColor: AppColors.whileColor),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        // Pick an image
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          log("Image Path: ${image.path} -- MimeType: ${image.mimeType}");
                          setState(() {
                            _img = image.path;
                          });
                          // for hiding bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      child: Center(child: Image.asset("images/pickImg.png"))),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          fixedSize: Size(
                              mediaQuery.width * 0.3, mediaQuery.height * 0.15),
                          backgroundColor: AppColors.whileColor),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        // Pick an image
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.camera);
                        if (image != null) {
                          log("Image Path: ${image.path} -- MimeType: ${image.mimeType}");
                          setState(() {
                            _img = image.path;
                          });
                          // for hiding bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      child: Center(child: Image.asset("images/camera.png"))),
                ],
              ),
              SizedBox(
                height: mediaQuery.height * 0.05,
              )
            ],
          );
        });
  }
}
