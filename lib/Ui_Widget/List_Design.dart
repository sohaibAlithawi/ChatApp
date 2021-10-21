import 'package:flutter/material.dart';
import 'package:what_app/App_Screens/Pages/Conversation_Screen.dart';
import 'package:what_app/Services/Constants.dart';
import 'package:what_app/Services/CreateChatRoomIdMoth.dart';
import 'package:what_app/Services/database.dart';

class List_Design extends StatelessWidget {
  final String userName;
  final String userEmail;
  List_Design({this.userName, this.userEmail});
  MyDataBase dataBaseMethod = new MyDataBase();
  CreateChatRoomIdMoth chatRoomIdMoth = new CreateChatRoomIdMoth();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Row(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: new Column(
              children: [
                new Text(
                  "$userName",
                  style: TextStyle(fontSize: 25),
                ),
                new Text(
                  "$userEmail",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          new Spacer(),
          SizedBox(
            width: 120,
            height: 50,
            child: new RaisedButton(
              onPressed: () {
                  chatRoomIdMoth.CreateChatRoom(userName, context);
              },
              color: Colors.indigo,
              elevation: 2,
              shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: new Text(
                "Message",
                style: TextStyle(fontSize: 21),
              ),
            ),
          )
        ],
      ),
    );
  }
}
