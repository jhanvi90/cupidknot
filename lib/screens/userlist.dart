import 'dart:convert';
import 'package:cupidknot/constant/constants.dart';
import 'package:cupidknot/models/userdata.dart';
import 'package:cupidknot/screens/sharedprefrences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserLists extends StatefulWidget {
  const UserLists({Key key}) : super(key: key);

  @override
  _UserListsState createState() => _UserListsState();
}

class _UserListsState extends State<UserLists>
{





  Future<userData> fetchUsers() async {
    MySharedPreferences mySharedPreferences = new MySharedPreferences();
    String accessToken = await mySharedPreferences.getAccessToken();
    Uri url = Uri.parse("${Constants.BASE_URL}/users");
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      final jsonresponse = json.decode(response.body);
      return userData.fromJson(jsonresponse);
    } else if (response.statusCode == 401 || response.statusCode == 400) {
      String accessToken = await mySharedPreferences.getAccessToken();
      Uri url = Uri.parse("${Constants.BASE_URL}/refresh");
      final response = await http.post(url,
          body: jsonEncode({
            "access_token": accessToken
          }),
          headers:
          {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          });
      if (response.statusCode == 200) {
        fetchUsers();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("User Details",style: TextStyle(color: Colors.black),),
        actions: [
         IconButton(icon:Icon(Icons.logout,color: Colors.black,),onPressed: (){

         },),

        ],
      ),
      body: Container(
        child: FutureBuilder<userData>(
          future: fetchUsers(),
           builder: (context, snapshot)
           {
            if(snapshot.hasData)
              {
                return ListView.builder(

                    itemCount: snapshot.data.data.data.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index)
                    {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Text(snapshot.data.data.data[index].firstName.toString()),
                              SizedBox(height: 10,),
                              Text(snapshot.data.data.data[index].email.toString()),
                              SizedBox(height: 20,),
                              ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.data.data[index].userImages.length,
                                  itemBuilder: (BuildContext context, int index1)
                                  {
                                    return Image.network(
                                      snapshot.data.data.data[index].userImages[index1].path+
                                          snapshot.data.data.data[index].userImages[index1].name,width: 50,height: 50,
                                    );


                                  }
                              ),
                              SizedBox(height: 20,),
                              Divider(color: Colors.grey,)
                            ],
                          ),
                        );
                    }

                );
              }
            else if(snapshot.hasError)
              {
                return snapshot.error;
              }
            else{
              return Center(child: CircularProgressIndicator());
            }
          }
        ),
      ),
    );
  }
}
