
import 'package:chatapp_firebase/auth/loginScreen.dart';
import 'package:chatapp_firebase/model/chat_model.dart';
import 'package:chatapp_firebase/screens/home_screen.dart';
import 'package:chatapp_firebase/screens/splash_screen.dart';
import 'package:chatapp_firebase/utills/routes/routes_names.dart';
import 'package:flutter/material.dart';

class Routes {
    List<ChatModel> chatList = [];
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RoutesNames.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RoutesNames.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
    /*   case RoutesNames.profileScreen:
        return MaterialPageRoute(builder: (context) =>  const ProfileScreen(user: chatList[0],));
 */
      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(child: Text("No Route is Selected")),
                ));
    }
  }
}
