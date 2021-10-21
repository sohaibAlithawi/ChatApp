
import 'package:what_app/App_Screens/TabBar%20Screens/Add%20Friends.dart';
import 'package:what_app/App_Screens/TabBar%20Screens/Chats.dart';
import 'package:what_app/App_Screens/TabBar%20Screens/My%20Profile.dart';
import 'package:what_app/Services/HelperFunction.dart';
import 'package:what_app/Ui_Widget/ConstantsColors.dart';
import 'package:what_app/Ui_Widget/Drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key }) : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ConstantsColors colors = new ConstantsColors();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home:DefaultTabController(
        length: 3,
        child: Scaffold(

          drawer: MyDrawer(context),
            appBar: AppBar(
              title: new Text("Messenger",style: TextStyle(fontSize: 20),),
              centerTitle: true,
              backgroundColor: colors.colors_blueGrey_700,
              bottom: TabBar(labelColor: Colors.blueGrey[100],indicatorColor: Colors.greenAccent,tabs: [
                Tab(child: new Text("Chats",style: TextStyle(fontSize: 18),),),
                Tab(child: new Text("Add Friends",style: TextStyle(fontSize: 18),),),
                Tab(child: new Text("My Profile",style: TextStyle(fontSize: 18),),),
              ],),
            ),
            body: new Stack(children: [
              new TabBarView(children: [
                Chats_Screen(),
                Add_Friends_Screen(),
                MyProfile_Screen()
              ])
            ],),
        ),
      ),



    );
  }

}
