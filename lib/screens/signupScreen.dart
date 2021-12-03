import 'dart:convert';
import 'package:cupidknot/screens/homeScreen.dart';
import 'package:cupidknot/screens/loginscreen.dart';
import 'package:cupidknot/screens/sharedprefrences.dart';
import 'package:cupidknot/constant/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;


class signUp extends StatefulWidget{
  @override
  _signUpState createState()=> _signUpState();
}
class _signUpState extends State<signUp> {

  int s_day = 1;
  int s_month = 1;
  int s_year = 1980;
  var gender;
  var selectedGender;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _dateofbirth = TextEditingController();

  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }


  MySharedPreferences preferences = MySharedPreferences();
  void _registerUser() async {
    Uri url = Uri.parse("${Constants.BASE_URL}/register");
    final response = await http.post(url,
        body: jsonEncode({
          "first_name": _firstnameController.text,
          "last_name": _lastnameController.text,
          "email": _emailController.text,
          "password": _passwordController.text,
          "password_confirmation": _confirmpasswordController.text,
          "birth_date": _dateofbirth.text,
          "gender": selectedGender
        }),
        headers:
        {
         'Content-Type': 'application/json',
          'Accept': 'application/json'
        });
    print(response.body);
    if (response.statusCode == 200)
    {
      var responseData= json.decode(response.body);
      preferences.setAccessToken(responseData['access_token']);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homescreen()),);
      _formKey.currentState.reset();

    }else
    {
      print("Failed to register" + response.body.toString());
    }

  }



  Widget SignUpWidget(BuildContext context)
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
              child:Text("Sign Up", style: TextStyle(fontSize: 30,color: Colors.red,fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 3),
            Container(child:  Text("Create your account",style: TextStyle(fontSize: 14, color: Colors.red.withOpacity(0.8))),),
            SizedBox(height:screenHeight*0.03),
            Padding(
              padding:  EdgeInsets.only(left:screenWidth*0.02,top:screenHeight*0.01,right:screenWidth*0.02 ),
              child: Container(
                child: TextFormField(
                  controller: _firstnameController,
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
                      hintText: 'First Name',
                      prefixIcon: Icon(Icons.person,color: Colors.black,),
                      filled: true, fillColor: Colors.white70),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left:screenWidth*0.02,top:screenHeight*0.01,right:screenWidth*0.02 ),
              child: Container(
                child: TextFormField(
                  controller: _lastnameController,
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
                      hintText: 'Last Name', prefixIcon: Icon(Icons.person,color: Colors.black,),
                      filled: true, fillColor: Colors.white70),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left:screenWidth*0.02,top:screenHeight*0.01,right:screenWidth*0.02 ),
              child: Container(
                child: TextFormField(
                  controller: _emailController,
                  validator: (value){
                    if(value.isEmpty)
                    {
                      return 'Please enter email address';
                    }
                    else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Email', prefixIcon: Icon(Icons.email,color: Colors.black,),
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
            Padding(
              padding:  EdgeInsets.only(left:screenWidth*0.02,top:screenHeight*0.01,right:screenWidth*0.02 ),
              child: Container(
                child: TextFormField(
                  controller: _confirmpasswordController,
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
                      hintText: 'Confirm Password',
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
            Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextFormField(
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      onCancel: () {
                       // Fluttertoast.showToast(msg: "Please select a date");
                      },
                      showTitleActions: true,
                      minTime: DateTime(1990, 1, 1),
                      maxTime: DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day),
                      onChanged: (date) {
                      },
                      onConfirm: (date) {
                        setState(() {
                          _dateofbirth.text =
                          "${date.year}/${date.month}/${date.day}";
                          s_day = date.day;
                          s_month = date.month;
                          s_year = date.year;
                        });
                      },
                    );
                  },
                  controller: _dateofbirth,
                  onSaved: (value) => _dateofbirth.text = value,
                  validator: (value) =>
                  value.isEmpty ? "Please select date" : null,
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: ' Select Date of Birth',
                      prefixIcon: Icon(Icons.calendar_today,color: Colors.black,),
                       filled: true,fillColor: Colors.white70),
                ),
           ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Gender",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(border: Border.all()),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.06,
                child: DropdownButton(
                    underline: SizedBox(),
                    onChanged: (value) {

                        setState(() {
                          gender = value;
                        });
                        if (value == 1) {
                          setState(() {
                            selectedGender = 'MALE';
                          });
                        } else {
                          setState(() {
                            selectedGender = 'FEMALE';
                          });
                        }

                    },
                    isExpanded: true,
                    value: gender,
                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                    items: [
                      DropdownMenuItem(
                        child: Text("Male"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text("Female"),
                        value: 2,
                      ),

                    ]),
              ),
            ),
            SizedBox(height:screenHeight*0.05),
            GestureDetector(
              onTap: (){
                if (_formKey.currentState.validate()) {
                  setState(()
                  {
                    //Method to register user
                    _registerUser();
                  });
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
                      const Text("SIGN UP", style: TextStyle(color: Colors.white, fontSize: 20),),
                      IconButton(icon: Icon(Icons.arrow_forward_rounded,color: Colors.white,),iconSize: 25,color: Colors.black54, onPressed: () {  },)
                    ]
                ),
              ),
            ),
            SizedBox(height: screenHeight*0.03),
            Text("Already have an account?",style: TextStyle(fontSize: 13)),
            SizedBox(height: screenHeight*0.01),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => signIn()),);
              },
              child: Container(child:Text("SIGN IN NOW", style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
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
                  // SignUp design widget
                    child: SignUpWidget(context)
                )
            )
        )
    );
  }






}
