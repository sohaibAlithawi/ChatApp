import 'package:what_app/App_Screens/Pages/HomePage.dart';
import 'package:what_app/App_Screens/Pages/LoginScreen.dart';
import 'package:what_app/Ui_Widget/SHowLoading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: new Container(
             width: MediaQuery.of(context).size.width,
              height:350 ,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('images/welcome_image.png'),
                ),
              ),
            ),
          ),

          WelcomeScreenBody(),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: new RaisedButton(
                    elevation: 5,
                    color: Colors.red,
                    onPressed: () {
                      _UpdateWelcomeScreen();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: new Text(
                      "Get Started",
                      style: TextStyle(fontSize: 20),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            )

        ],
        ),
      ),
    );
  }

  WelcomeScreenBody() {
    return new Column(
      children: [
        //TODO: Title
        new Text(
          "Welcome To Our \nChat App",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),

        //TODO: Space
        new SizedBox(
          height: 15,
        ),

        //TODO: Description
        new Text(
          "This app is similar to whats app but with other deign",
          textAlign: TextAlign.center,
        ),

        //TODO: Space
        new SizedBox(
          height: 80,
        ),


      ],
    );
  }


  _UpdateWelcomeScreen() async {
    SharedPreferences prefernc = await SharedPreferences.getInstance();
    prefernc.setBool('seen', true);
  }
}
