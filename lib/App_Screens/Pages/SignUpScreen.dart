import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:what_app/Services/HelperFunction.dart';
import 'package:what_app/Services/database.dart';
import 'package:what_app/Ui_Widget/SHowLoading.dart';
import 'package:what_app/Ui_Widget/TopWelcomeBackContainer.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {


  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  var userName , email , password, imageUrl;
  FirebaseAuth instance = FirebaseAuth.instance;
  MyDataBase myDataBase = new MyDataBase();
  final _formKey = GlobalKey<FormState>();
  bool isLoading ;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: new Column(
            children: [
                TopWBContaier(context,"SingUp \nScreen"),
                Body(context)
            ],
          ),
        ),
      ),
    );
  }

  Body(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [

          // TODO: Name Text Field

          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              autocorrect: true,
              obscureText: false,
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                hintText: "Enter your Name",
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onChanged: (value){
                userName = value;
              },
            ),
          ),

          // TODO: Email Text Field

          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              autocorrect: true,
              obscureText: false,
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                hintText: "Enter your Email",
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onChanged: (value) {
                email = value;
              },
            ),
          ),

          // TODO: Password Text Field

          Padding(
            padding: EdgeInsets.all(15),
            child: new TextFormField(
              autocorrect: true,
              obscureText: true,
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
              decoration: InputDecoration(
                icon: Icon(Icons.password),
                hintText: "Enter your password",
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onChanged: (value) {
                password = value;
              },
            ),
          ),

          // TODO: SingUp Button
          Padding(
            padding: EdgeInsets.all(20),
            child: new Container(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                elevation: 20,
                color: Colors.greenAccent[700],
                onPressed: () {
                  SignUp(context);
                  },
                child: Text(
                  'Sing Up',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),

          // TODO: Back to Login Screen Button
          Padding(
            padding: EdgeInsets.all(20),
            child: new Container(
              width: double.infinity,
              height: 50,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: new Text(
                    "Go Back",
                    style: TextStyle(fontSize: 15),
                  )),
            ),
          ),
        ],
      )
    );
  }




  dynamic SignUp(BuildContext context) async {

     Map <String,dynamic> UserMap= {
       'Email' : email,
       'Username' : userName,

     };

     HelperFunction.saveUserEmailSharedPreference(email);
     HelperFunction.saveUserNameSharedPreference(userName);


    UserCredential _userCredential;
    try {
      _userCredential = await instance.createUserWithEmailAndPassword(
          email: this.email.trim(), password: this.password.trim());


        MyDataBase().UploadUserInfo(UserMap);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } on FirebaseAuthException catch (error) {
      FirebaseExceptionFun(error,context);
    }

    return _userCredential;
     }






  dynamic FirebaseExceptionFun(FirebaseAuthException error,BuildContext context) {


    //TODO:exception for INVALID EMAIL;
    if (error.code == 'invalid-email') {

      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Error',
        confirmBtnText: "Close",
        confirmBtnColor: Colors.amber ,
        animType: CoolAlertAnimType.slideInDown,
        text: 'You have entered Invalid Email',

      );
      print("from printer invalid email");
    }


    //TODO:exception for Weak-Password;
    else if (error.code == 'weak-password') {

      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Error',
        confirmBtnText: "Close",
        confirmBtnColor: Colors.amber ,
        animType: CoolAlertAnimType.slideInDown,
        text: 'Your password is too weak',

      );
      print("from printer password too weak");
    }

    //TODO:exception for Email-Already-In-Use;

    else if (error.code == 'email-already-in-use') {

      CoolAlert.show(
        context: context,
        type: CoolAlertType.warning,
        title: 'Warning',
        confirmBtnText: "Close",
        confirmBtnColor: Colors.amber ,
        animType: CoolAlertAnimType.slideInDown,
        text: 'Your account is already in used',

      );

    }

    //TODO:exception for user disabled;
    else if (error.code == 'user-disabled') {

      CoolAlert.show(
        context: context,
        type: CoolAlertType.warning,
        title: 'Warning',
        confirmBtnText: "Close",
        confirmBtnColor: Colors.amber ,
        animType: CoolAlertAnimType.slideInDown,
        text: 'Your account is disabled',

      );

    }
  }

}
