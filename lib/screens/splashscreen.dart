import 'dart:async';

import 'package:cupidknot/screens/homeScreen.dart';
import 'package:cupidknot/screens/loginscreen.dart';
import 'package:cupidknot/screens/sharedprefrences.dart';
import 'package:flutter/material.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key key}) : super(key: key);

  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  getData() async {
    MySharedPreferences mySharedPreferences = new MySharedPreferences();
    String accessToken = await mySharedPreferences.getAccessToken();
    Timer(Duration(seconds: 3), () {
      if(accessToken == null)
      {
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => signIn()),
        );
      }
      else{
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homescreen()),
        );
      }
    });

  }

  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
          child: Image.asset('assets/images/index.jpeg')
      ),
    );
  }
}
