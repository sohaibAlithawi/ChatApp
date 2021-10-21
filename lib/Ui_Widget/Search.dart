import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:what_app/App_Screens/Pages/Conversation_Screen.dart';
import 'package:what_app/Services/Constants.dart';
import 'package:what_app/Services/HelperFunction.dart';
import 'package:what_app/Services/database.dart';
import 'package:what_app/Ui_Widget/Drawer.dart';
import 'package:what_app/Ui_Widget/List_Design.dart';

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {


 var _myName;
  MyDataBase dataBaseMethod = new MyDataBase();
  QuerySnapshot searchSnapshot;

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: [Search(context), SearchList()],
    );
  }



  InitialSearchMethod(searchValue) {
    dataBaseMethod.getUserByUsername(searchValue).then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }


  SearchList() {
    return searchSnapshot != null
        ? ListView.builder(
        shrinkWrap: true,
        itemCount: searchSnapshot.docs.length,
        itemBuilder: (context, index) {
          return List_Design(
            userName:  searchSnapshot.docs[index].data()['Username'],
            userEmail: searchSnapshot.docs[index].data()['Email'],
          );
        })
        : new Container(child: new Text("Please enter the full name of your friends"),);
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

    getUserInfo()async{
      _myName = await HelperFunction.getUserEmailSharedPreference();
      print("${_myName}");
    }

  Search(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: new Container(
          child: Align(
        alignment: Alignment.topLeft,
        child: new TextFormField(
          autocorrect: true,
          obscureText: false,
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
          decoration: InputDecoration(
            hintText: "Search For Friends",
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onChanged: (value) {
                InitialSearchMethod(value);

          },
        ),
      )),
    );
  }
}