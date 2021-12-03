import 'dart:convert';
import 'package:cupidknot/constant/constants.dart';
import 'package:cupidknot/screens/homeScreen.dart';
import 'package:cupidknot/screens/sharedprefrences.dart';
import 'package:cupidknot/screens/signupScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class signIn extends StatefulWidget{
  @override
  _signUpState createState()=> _signUpState();
}
class _signUpState extends State<signIn> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  MySharedPreferences preferences = MySharedPreferences();
  void _authenticate() async
  {
    Uri url = Uri.parse("${Constants.BASE_URL}/login");
    final response = await http.post(url,
        body: jsonEncode({
          "username": _usernameController.text,
          "password": _passwordController.text,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        });
    print(response.body);
    if (response.statusCode == 200) {
      var responseData= json.decode(response.body);
      preferences.setAccessToken(responseData['access_token']);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homescreen()),);
      _formKey.currentState.reset();
    } else {

      print("Failed to login" + response.body.toString());
    }

  }

  //SignUp Screen design widget
  Widget SignInWidget(BuildContext context)
  {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top:55.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child:Text("Sign In", style: TextStyle(fontSize: 30,color: Colors.red,fontWeight: FontWeight.bold)),
            ),

            Padding(
              padding:  EdgeInsets.only(left:screenWidth*0.02,top:screenHeight*0.01,right:screenWidth*0.02 ),
              child: Container(
                child: TextFormField(
                  controller: _usernameController,
                  validator: (value){
                    if(value.isEmpty)
                    {
                      return 'Please enter name';
                    }
                    else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'User Name',
                      prefixIcon: Icon(Icons.person,color: Colors.black,),
                      filled: true, fillColor: Colors.white70),
                ),
              ),
            ),


            Padding(
              padding:  EdgeInsets.only(left:screenWidth*0.02,top:screenHeight*0.01,right:screenWidth*0.02 ),
              child: Container(
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: !_showPassword,
                  validator: (value){
                    if(value.isEmpty)
                    {
                      return 'Please enter password';
                    }
                    else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock,color: Colors.black,),
                      suffixIcon: IconButton(
                        icon: Icon(_showPassword?Icons.visibility:Icons.visibility_off,color: Colors.black,size: 20,),
                        onPressed: ()
                        {
                          _togglevisibility();
                        },
                      ), filled: true,fillColor: Colors.white70),
                ),
              ),
            ),

            SizedBox(height:screenHeight*0.05),
            GestureDetector(
              onTap: (){
                if (_formKey.currentState.validate()) {
                _authenticate();
                }
              },
              child: Container(
                padding:  EdgeInsets.only(left: screenWidth*0.09, top: screenHeight*0.01, right: screenWidth*0.01, bottom: screenHeight*0.01),
                decoration:  BoxDecoration(
                    gradient:  LinearGradient(colors: [Colors.red, Colors.red.withOpacity(0.7)]),
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(40), left: Radius.circular(40))
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("SIGN IN", style: TextStyle(color: Colors.white, fontSize: 20),),
                      IconButton(icon: Icon(Icons.arrow_forward_rounded,color: Colors.white,),iconSize: 25,color: Colors.black54, onPressed: () {  },)
                    ]
                ),
              ),
            ),

            SizedBox(height: screenHeight*0.01),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => signUp()),);
              },
              child: Container(child:Text("SIGN UP", style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
            ),
          ]
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  // SignIn design widget
                    child: SignInWidget(context)
                )
            )
        )
    );
  }

}
