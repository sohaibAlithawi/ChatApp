import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:what_app/Services/HelperFunction.dart';
import 'package:what_app/Services/database.dart';
import 'package:what_app/Ui_Widget/List_Design.dart';

class MyProfile_Screen extends StatefulWidget {
  const MyProfile_Screen({Key key}) : super(key: key);

  @override
  _MyProfile_ScreenState createState() => _MyProfile_ScreenState();
}

class _MyProfile_ScreenState extends State<MyProfile_Screen> {
  var _myName;
  CollectionReference ref = FirebaseFirestore.instance.collection('Users');
  MyDataBase dataBaseMethod = MyDataBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: new Center(child: new Text("Hello From My Profile Screen"),),
    );
  }
}
