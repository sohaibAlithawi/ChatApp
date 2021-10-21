import 'package:flutter/material.dart';
import 'package:what_app/App_Screens/Pages/HomePage.dart';
import 'package:what_app/App_Screens/TabBar%20Screens/Add%20Friends.dart';
import 'package:what_app/Services/Constants.dart';
import 'package:what_app/Services/HelperFunction.dart';
import 'package:what_app/Services/database.dart';
import 'package:what_app/Ui_Widget/ChatRoomTile.dart';
import 'package:what_app/Ui_Widget/ConstantsColors.dart';
import 'package:what_app/Ui_Widget/List_Design.dart';

class Chats_Screen extends StatefulWidget {
  @override
  _Chats_ScreenState createState() => _Chats_ScreenState();
}

class _Chats_ScreenState extends State<Chats_Screen> {
  ConstantsColors colors = new ConstantsColors();
  Stream chatRoomStream;
  MyDataBase dataBase = new MyDataBase();

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  MyChats() {
    return new StreamBuilder(
        stream: chatRoomStream,
        // ignore: missing_return
        builder: (context, snapshot) {

            if (!snapshot.hasData){
              return new Container();
            }else{
              return  ListView.builder(

                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return ChatRoomTile(

                      snapshot.data.docs[index].data()['userRoomId']
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll("${Constants.myName}", ""),
                      snapshot.data.docs[index].data()['userRoomId'],
                    );
                  });
            }

        });
  }

  getUserInfo() async {
    Constants.myName = await HelperFunction.getUserNameSharedPreference();
    dataBase.getChatRooms(Constants.myName).then((val) {
      setState(() {
        chatRoomStream = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.color_blueGrey_900,
        body: new Stack(
          children: [
            MyChats(),
            Padding(
              padding: EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () {
                    DefaultTabController.of(context).animateTo(1);
                  },
                  backgroundColor: Colors.greenAccent[700],
                  elevation: 5,
                  child: Icon(
                    Icons.chat,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
