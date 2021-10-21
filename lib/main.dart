
import 'package:what_app/App_Screens/Pages/Conversation_Screen.dart';
import 'package:what_app/App_Screens/Pages/HomePage.dart';
import 'package:what_app/App_Screens/Pages/WlecomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'App_Screens/Pages/LoginScreen.dart';
import 'Ui_Widget/SHowLoading.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefernc = await SharedPreferences.getInstance();
  bool seen = prefernc.getBool('seen');
  Widget Screens;

  if (seen == null || seen == false) {
    Screens = WelcomeScreen();
  } else {
    Screens = LoginScreen();
  }
  runApp(MyApp(Screens));

}

class MyApp extends StatefulWidget {


  Widget _Screen;

  MyApp(this._Screen);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: this.widget._Screen
    );
  }
}
