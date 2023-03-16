import 'package:chatapp_firebase/utills/routes/routes.dart';
import 'package:chatapp_firebase/utills/routes/routes_names.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

late Size mediaQuery;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky); // open application full screen
//Then go to andriod/app/src/main/res/values/style.xml // paste item line in it also pase same line in both style.xml files
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.purple),
          iconTheme: const IconThemeData(color: Colors.white)),
      initialRoute: RoutesNames.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
