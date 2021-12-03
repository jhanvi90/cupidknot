import 'package:cupidknot/screens/loginscreen.dart';
import 'package:cupidknot/screens/profileDetails.dart';
import 'package:cupidknot/screens/signupScreen.dart';
import 'package:cupidknot/screens/userlist.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
{
  int _selectedIndex = 0;
  var _pageData = [
    UserLists(),
    profileDetails(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageData[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon:  Icon(Icons.home),
                  label: 'Home',
                ),


                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),

              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.red,
              onTap: _onItemTapped,
              unselectedItemColor: Colors.black,
              elevation: 5,
              type: BottomNavigationBarType.fixed,
            ),);

  }
}
