import 'package:flutter/material.dart';
import 'package:what_app/Services/Constants.dart';
import 'package:what_app/Services/HelperFunction.dart';
import 'package:what_app/Services/database.dart';
import 'package:what_app/Ui_Widget/ConstantsColors.dart';
import 'package:what_app/Ui_Widget/MessageWidgets.dart';

class Conversation_Screen extends StatefulWidget {
  final String ChatRoomId;
  Conversation_Screen(this.ChatRoomId);

  @override
  _Conversation_ScreenState createState() => _Conversation_ScreenState();
}

class _Conversation_ScreenState extends State<Conversation_Screen> {
  ConstantsColors colors = new ConstantsColors();
  String message;
  MyDataBase dataBase =new MyDataBase();
  Stream chatMassageStream;
  bool isLoading = null;
  var fieldText = TextEditingController();


  @override
  void initState() {
    dataBase.getConversationMessage(widget.ChatRoomId).then((val){
      setState(() {
        chatMassageStream = val;
      });
    });
    super.initState();
  }

  SendMessage(){
   if (message.isNotEmpty){
      Map<String ,dynamic > messageMap={

        "Message": message,
        "SendBy" : Constants.myName,
        'time' : DateTime.now().millisecondsSinceEpoch,
      };
      dataBase.addConversationMessage(widget.ChatRoomId, messageMap);
      message = "";
    }
  }

 Widget ChatMessageList(){

   return StreamBuilder(
        stream: chatMassageStream,
        // ignore: missing_return
        builder: (context, snapshot){

          if (snapshot.hasData){
            return new Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height *0.7+58,
              child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context,index){
                    return  MessageWidgets(snapshot.data.docs[index].data()['Message'],
                        snapshot.data.docs[index].data()['SendBy'] == Constants.myName);
                  }),
            );
          }else{
           return new Container();
          }

    });
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.colors_blueGrey_700,
        title: Text("Conversation"),
        centerTitle: true,
        actions: [
          new IconButton(onPressed: (){},icon:Icon(Icons.call)),
          new IconButton(onPressed: (){},icon:Icon(Icons.more_vert)),

        ],
      ),
      backgroundColor: colors.color_blueGrey_900,
      body: new Stack(
        children: [
          ChatMessageList(),

          new  Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: new Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: new Container(
                        width: 320,
                        height: 50,
                        decoration: BoxDecoration(
                            color: colors.colors_blueGrey_700,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: new Container(

                            margin: EdgeInsets.only(left: 10),
                          child: TextField(
                               controller: fieldText,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Send Message",
                              ),
                        onChanged: (value){
                          message = value;
                        },
                          ),
                        ),
                      ),
                    ),
                    new SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Container(
                        width: 50,
                        height: 50,
                        child: RaisedButton(
                          elevation: 5,
                          onPressed: (){
                            SendMessage();
                            fieldText.clear();
                          },
                          color: Colors.greenAccent[400],
                          child: Icon(Icons.send),
                          shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        ),
                      ),
                    )
                  ],
                ),
              )

            ],
          )
        ],
    )

      );

  }
}

