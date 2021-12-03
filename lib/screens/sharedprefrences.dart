import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {

    Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var loginUserId = prefs.getString('accessToken');
    return loginUserId;
  }

  void setAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', token);
  }

    Future<String> getRefreshToken() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var loginUserId = prefs.getString('refreshToken');
      return loginUserId;
    }

    void setRefreshToken(String token) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('refreshToken', token);
    }
}
