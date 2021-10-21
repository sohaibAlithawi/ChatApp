import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:what_app/App_Screens/Pages/Conversation_Screen.dart';

class ChatRoomTile extends StatelessWidget {
  final String UserName;
  final String ChatRoomId;

  ChatRoomTile(this.UserName, this.ChatRoomId);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading: new Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.indigo, borderRadius: BorderRadius.circular(10)),
        child: Align(
          alignment: Alignment.center,
          child: new Text(
            "${UserName.substring(0, 1).toUpperCase()}",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      title: Text(
        "$UserName",
        style: TextStyle(fontSize: 20),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Conversation_Screen(ChatRoomId),
          ),
        );
      },
    );
  }
}
