import 'package:what_app/Ui_Widget/Search.dart';
import 'package:flutter/material.dart';

class Add_Friends_Screen extends StatefulWidget {
  const Add_Friends_Screen({Key key}) : super(key: key);

  @override
  _Add_Friends_ScreenState createState() => _Add_Friends_ScreenState();
}

class _Add_Friends_ScreenState extends State<Add_Friends_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body:new Column(
        children: [
          Search(),
        ],
      )
    );
  }
}
