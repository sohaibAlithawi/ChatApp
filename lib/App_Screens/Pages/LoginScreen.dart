import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:what_app/Services/HelperFunction.dart';
import 'package:what_app/Services/database.dart';
import 'package:what_app/Ui_Widget/SHowLoading.dart';
import 'package:what_app/Ui_Widget/TopWelcomeBackContainer.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'SignUpScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth instance = FirebaseAuth.instance;
  var email, password;
  bool isLoading=false;

  MyDataBase myDataBase = new MyDataBase();
  QuerySnapshot snapshotUserInfo;
  @override
  void initState() {

    instance.authStateChanges().listen((User user) {

      if(user == null){
        print("No User Found");

      }else{
        print("User Found");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
      }
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: new Column(
          children: [
            TopWBContaier(context, "Welcome \nBack"),
            Padding(
                padding: EdgeInsets.all(20),
                child:  Body()
            ),
          ],
        ),
      )
    );
  }

  Body() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // TODO: Email Text Field
          Padding(
            padding: EdgeInsets.all(5),
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
            padding: EdgeInsets.all(5),
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

          LoginScreenButtons(context)
        ],
      )
    );

  }
  LoginScreenButtons(BuildContext context) {
    return new Column(
      children: [
        // TODO: Login Button
        Padding(
          padding: EdgeInsets.all(20),
          child: new Container(
            width: double.infinity,
            height: 50,
            child: RaisedButton(
              elevation: 20,
              color: Colors.blueAccent[400],
              onPressed: () {
                SignIn();
              },
              child: Text(
                'Sing In',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
              ),
            ),
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
              onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );},
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


      ],
    );
  }

  dynamic SignIn() async {
    UserCredential _userCredential;
    try {





      myDataBase.getUserByUserEmail(email).then((value){
        snapshotUserInfo = value;
       // HelperFunction.saveUserNameSharedPreference(snapshotUserInfo.docs[0].data()['Username']);
      });
      _userCredential = await instance.signInWithEmailAndPassword(
          email: this.email.trim(), password: this.password.trim());

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } on FirebaseAuthException catch (error) {
      FirebaseExceptionFun(error);
    }

    return _userCredential;
  }

  dynamic FirebaseExceptionFun(FirebaseAuthException error) {
    //TODO:exception for INVALID EMAIL;
    if (error.code == 'invalid-email') {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Error',
        confirmBtnText: "Close",
        confirmBtnColor: Colors.amber,
        animType: CoolAlertAnimType.slideInDown,
        text: 'You are using Invalid Email',

      );
      print("from print invalid email");
    }


    //TODO:exception for USER NOT FOUND;
    else if (error.code == 'user-not-found') {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Error',
        confirmBtnText: "Close",
        confirmBtnColor: Colors.amber,
        animType: CoolAlertAnimType.slideInDown,
        text: 'This User not found',

      );
      print("from print user not found");
    }


    //TODO:exception for wrong password;
    else if (error.code == 'wrong-password') {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Error',
        confirmBtnText: "Close",
        confirmBtnColor: Colors.amber,
        animType: CoolAlertAnimType.slideInDown,
        text: 'you have entered wrong password',

      );
    }

    //TODO:exception for user disabled;
    else if (error.code == 'user-disabled') {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Error',
        confirmBtnText: "Close",
        confirmBtnColor: Colors.amber,
        animType: CoolAlertAnimType.slideInDown,
        text: 'This account has been disabled',

      );
    }
  }

}
