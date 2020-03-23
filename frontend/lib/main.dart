import 'package:digicoronatest/pages/arzthomepage.dart';
import 'package:digicoronatest/splashscreen.dart';
import 'package:digicoronatest/widget/overview.dart';
import 'package:flutter/material.dart';
import 'widget/messaging_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String appTitle = 'Send push notifications';
  String token = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == "/") {
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => MainPage(),
          );
        }
        if (settings.name == "/overview") {
          String arguments = settings.arguments;

          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => Overview(arguments),
          );
        }
        if (settings.name == "/splashscreen") {
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => SplashScreen(),
          );
        }
        if (settings.name == "/arzthomepage") {
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => Arzthomepage(),
          );
        }
        return null;
      },

//        home: MainPage(appTitle: appTitle),
    );
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

class MainPage extends StatelessWidget {
  final String appTitle = "Digi Corona App";

  const MainPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            MaterialButton(
              color: Colors.blue,
              child: Text("Starte Ärzte App"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/arzthomepage");
              },
            ),
            MaterialButton(
              color: Colors.green,
              child: Text("Starte Patienten-App"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/splashscreen");
              },
            )
          ],
        ),
      ),
    );
  }
}
