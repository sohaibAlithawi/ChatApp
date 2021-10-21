import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:what_app/Services/HelperFunction.dart';
import 'package:what_app/Ui_Widget/Drawer.dart';

TopWBContaier(BuildContext context, String title) {
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  return new Container(
    width: double.infinity,
    height: 350,
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
        color: Colors.blueAccent[700],
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
    child: Transform.translate(
      offset: Offset(20,220),
      child: new Text(
        "$title",
        style: TextStyle(
            fontSize: 40, color: Colors.white, fontWeight: FontWeight.w500),
      ),
    ),
  );
}
