import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:what_app/App_Screens/Pages/Conversation_Screen.dart';
import 'package:what_app/Services/database.dart';
import 'package:what_app/Ui_Widget/List_Design.dart';

import 'Constants.dart';

class CreateChatRoomIdMoth{
MyDataBase dataBaseMethod = new MyDataBase();




     CreateChatRoom(String userName,context){

       if (userName != Constants.myName){

         String ChatRoomId = getChatRoomId(userName, Constants.myName);
         List<String> users = [userName, Constants.myName];
         Map<String,dynamic> ChatRoomMap = {
           'users': users,
           'userRoomId': ChatRoomId,
         };


         dataBaseMethod.CreateChatRoom(ChatRoomId, ChatRoomMap);
         Navigator.push(context, MaterialPageRoute(builder: (context)=> Conversation_Screen(ChatRoomId)));
       }else{
         print("The username was the same");
         CoolAlert.show(
           context: context,
           type: CoolAlertType.error,
           title: 'Error',
           confirmBtnText: "Close",
           confirmBtnColor: Colors.amber ,
           animType: CoolAlertAnimType.slideInDown,
           text: 'You can not send a message to your self',

         );
       }


     }



}


  getChatRoomId(String a , String b){
    if (a.substring(0,1).codeUnitAt(0) > b.substring(0 ,1).codeUnitAt(0)){
      return "$b\_$a";
    }else{
      return "$a\_$b";
    }
  }
