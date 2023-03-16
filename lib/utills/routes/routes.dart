import 'package:chatapp_firebase/auth/loginScreen.dart';
import 'package:chatapp_firebase/screens/home_screen.dart';
import 'package:chatapp_firebase/screens/splash_screen.dart';
import 'package:chatapp_firebase/utills/routes/routes_names.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RoutesNames.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RoutesNames.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Text("No Route is Selected"),
                ));
    }
  }
}
