import 'pages/signuppage.dart';
import 'widget/overview.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    checkLoginStatus(context);
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[]));
  }

  Future<void> checkLoginStatus(BuildContext context) async {
    String token = await readfromShared("id");
    if (token != "") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Overview(token)));
    } else
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => SignupPage()));
  }

  Future<String> readfromShared(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key) ?? "";
    return value;
  }

  void savetoShared(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    print('saved $key and $value');
  }
}
