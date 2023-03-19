import 'package:chatapp_firebase/model/chat_model.dart';
import 'package:chatapp_firebase/res/colors.dart';
import 'package:chatapp_firebase/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../servicess/intenses.dart';
import '../widgets/chat_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatModel> _chatList = [];
  final List<ChatModel> _searchList = [];
  bool _isSearch = false;
  @override
  void initState() {
    super.initState();
    Instanses.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (_isSearch) {
            setState(() {
              _isSearch = !_isSearch;
            });
          } else {
            return Future.value(true);
          }
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
            centerTitle: true,
            title: _isSearch
                ? TextFormField(
                    autofocus: true,
                    style: TextStyle(
                        color: AppColors.whileColor,
                        letterSpacing: 0.5,
                        fontSize: 17),
                    cursorColor: AppColors.lightGreyColor,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Name, Email,...",
                        hintStyle: TextStyle(color: AppColors.lightGreyColor)),
                    onChanged: (value) {
                      _searchList.clear();
                      for (var i in _chatList) {
                        if (i.name
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            i.email
                                .toLowerCase()
                                .contains(value.toLowerCase())) {
                          _searchList.add(i);
                          setState(() {
                            _searchList;
                          });
                        }
                      }
                    },
                  )
                : const Text("Chat App"),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearch = !_isSearch;
                    });
                  },
                  icon: Icon(_isSearch
                      ? CupertinoIcons.clear_circled_solid
                      : Icons.search)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                ProfileScreen(user: Instanses.me))));
                    // Navigator.pushNamed(context, RoutesNames.profileScreen);
                  },
                  icon: const Icon(Icons.more_vert)),
            ],
          ),
          body: StreamBuilder(
              stream: Instanses.getAllUsers(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data!.docs;
                    _chatList =
                        data.map((e) => ChatModel.fromJson(e.data())).toList();
                    if (_chatList.isNotEmpty) {
                      return ListView.builder(
                          itemCount:
                              _isSearch ? _searchList.length : _chatList.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ChatCardW(
                                user: _isSearch
                                    ? _searchList[index]
                                    : _chatList[index]);
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
        ),
      ),
    );
  }
}
