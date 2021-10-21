import 'package:flutter/material.dart';

import 'ConstantsColors.dart';

class MessageWidgets extends StatelessWidget {
  final String message;
  final bool isSendByMe ;
  MessageWidgets([this.message,this.isSendByMe]);
  ConstantsColors colors = new ConstantsColors();

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerLeft : Alignment.centerRight,
     child: new Container(
       padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              topLeft:Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10) ),
          gradient: LinearGradient(
            colors: isSendByMe  ? [
             const Color(0xff007EF4),
             const Color(0xff2A75BC),
            ]:[
              const Color(0x1AFFFFFF),
              const Color(0x1AFFFFFF),
             ]
          )
        ),
       child: new Text("$message", style: TextStyle(fontSize: 20),),
      )
    );
  }
}
