import 'package:flutter/material.dart';


loading([context,bool isLoading]) {
  return isLoading != false ? new AlertDialog(
    title: new Text(
      "Loading ",
      style: TextStyle(fontSize: 15),
    ),
    content: new Container(
      width: 50,
      height: 70,

      child: new Column(
        children: [
          new Center(
            child: new CircularProgressIndicator(
              color: Colors.amber,backgroundColor: Colors.blue,
            ),
          ),
           Expanded(child: new SizedBox(height: 30,)),
          LinearProgressIndicator(color: Colors.amber,backgroundColor: Colors.blue,)
        ],
      ),
    ),
  ): print("isLoading is not true");
}
