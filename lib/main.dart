
import 'package:cupidknot/screens/signupScreen.dart';
import 'package:cupidknot/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return


    MaterialApp(
           debugShowCheckedModeBanner: false,
            home: splashScreen(),
    );
  }
}

