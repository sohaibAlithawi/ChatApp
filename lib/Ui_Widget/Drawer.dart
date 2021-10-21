import 'dart:io';
import 'dart:math';

import 'package:image_picker_platform_interface/src/types/picked_file/base.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:what_app/App_Screens/Pages/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:what_app/App_Screens/Pages/SignUpScreen.dart';

FirebaseAuth AuthInstance = FirebaseAuth.instance;
FirebaseFirestore FireInstance = FirebaseFirestore.instance;
CollectionReference DataRef = FirebaseFirestore.instance.collection('Users');



MyDrawer([BuildContext context]) {
  return Drawer(
    child: new ListView(
      children: [
        new SizedBox(
          width: double.infinity,
          height: 200,
          child: DrawerHeader(
            decoration: BoxDecoration(color: Colors.greenAccent),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                  },
                  child: new Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.indigo,
                        image: DecorationImage(image: ExactAssetImage('')),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: new Text(
                    "Hello Brother",
                    style: TextStyle(fontSize: 23),
                  ),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text("Sing Out"),
          onTap: () {
            AuthInstance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );

          },
        )
      ],
    ),
  );
}
