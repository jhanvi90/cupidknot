import 'dart:convert';
import 'package:cupidknot/screens/homeScreen.dart';
import 'package:cupidknot/screens/loginscreen.dart';
import 'package:cupidknot/screens/sharedprefrences.dart';
import 'package:intl/intl.dart';
import 'package:cupidknot/constant/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class profileDetails extends StatefulWidget{
  @override
  _signUpState createState()=> _signUpState();
}
class _signUpState extends State<profileDetails> {

  int s_day = 1;
  int s_month = 1;
  int s_year = 1990;
  var gender;
  var selectedGender;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _dateofbirth = TextEditingController();


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserDetails();
  }
  MySharedPreferences mySharedPreferences = new MySharedPreferences();
  void _updateUser() async {
    String accessToken = await mySharedPreferences.getAccessToken();
    Uri url = Uri.parse("${Constants.BASE_URL}/update_user");
    final prefs = await SharedPreferences.getInstance();
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
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        });
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("Failed to update" + response.body.toString());
    }
  }

  void _getUserDetails() async {
    String accessToken = await mySharedPreferences.getAccessToken();
    Uri url = Uri.parse("${Constants.BASE_URL}/user");
    final prefs = await SharedPreferences.getInstance();
    final response = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        });
    if (response.statusCode == 200) {
      var resp=json.decode(response.body);
      setState(() {
        _firstnameController.text=resp["first_name"];
        _lastnameController.text=resp["last_name"];
        _emailController.text=resp["email"];
        _dateofbirth.text=resp["birth_date"];
      });

    } else {

      print("Failed to load" + response.body.toString());
    }
  }


  //SignUp Screen design widget
  Widget SignUpWidget(BuildContext context)
  {
    //Screen Width and Height
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top:55.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child:Text("Profile Details", style: TextStyle(fontSize: 30,color: Colors.red,fontWeight: FontWeight.bold)),
            ),

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
                _updateUser();
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
                      const Text("Update", style: TextStyle(color: Colors.white, fontSize: 20),),
                      IconButton(icon: Icon(Icons.arrow_forward_rounded,color: Colors.white,),iconSize: 25,color: Colors.black54, onPressed: () {  },)
                    ]
                ),
              ),
            ),

          ]
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Balsamiq_Sans'),
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
