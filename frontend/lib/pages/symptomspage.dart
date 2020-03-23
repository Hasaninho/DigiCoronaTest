import 'dart:convert';

import 'package:digicoronatest/api/connectionhelper.dart';
import 'package:digicoronatest/widget/janeinfragewidget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Symptomspage extends StatefulWidget {
  Map<String, dynamic> formdata;
  Symptomspage(this.formdata, {Key key}) : super(key: key);

  @override
  _SymptomspageState createState() => _SymptomspageState();
}

class _SymptomspageState extends State<Symptomspage> {
  Map<String, bool> booleanfactors = Map();
  List<bool> isSelected;
  bool loading = false;
  bool submitted = false;

  @override
  void initState() {
    print("running initstate");
    isSelected = [true, false];
    booleanfactors["halsschmerzen"] = false;
    booleanfactors["husten"] = false;
    booleanfactors["schnupfen"] = false;
    booleanfactors["muedigkeit"] = false;
    booleanfactors["krisenregion"] = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("running build");
    print("formdata contains");
    print(widget.formdata);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Nun noch Symptome eintragen"),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: <Widget>[
            Janeinfragewidget(
                booleanfactors, "halsschmerzen", "Haben Sie Halsschmerzen?"),
            Janeinfragewidget(booleanfactors, "husten", "Haben Sie Husten?"),
            Janeinfragewidget(
                booleanfactors, "schnupfen", "Haben Sie Schnupfen?"),
            Janeinfragewidget(
                booleanfactors, "muedigkeit", "Fühlen Sie sich sehr müde?"),
            Janeinfragewidget(booleanfactors, "krisenregion",
                "Waren Sie in den letzten \n2 Wochen in Italien oder\neiner anderen Krisenregion?"),
            registerbutton()
          ],
        ),
      ),
    );
  }

  Widget registerbutton() {
    return loading
        ? CircularProgressIndicator()
        : MaterialButton(
            color: Colors.green,
            onPressed: () async {
              setState(() {
                loading = true;
              });
              Map<String, dynamic> payload = Map<String, dynamic>();
              payload["personaldata"] = widget.formdata;
              payload["symptoms"] = booleanfactors;
              payload["doctordata"] = [];
              int shouldcheck = calcsymptoms(booleanfactors);
              payload["should_check"] = shouldcheck;
              Map result = await ConnectionHelper.registerOnline(payload);
              print(result["data"]);
              if (result["status"] != 201) {
                setState(() {
                  loading = false;
                });
                Fluttertoast.showToast(
                    msg: "Es gab einen Fehler beim Registrieren",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
                return;
              }
              Map bodydict = jsonDecode(result["data"]);
              String id = bodydict["id"].toString();
              await this.savetoShared("id", id);
              print("switching to overview");
              Navigator.pushNamed(context, '/overview', arguments: id);
            },
            child: Text("Registrieren"),
          );
  }

  void savetoShared(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    print('saved $key and $value');
  }

  int calcsymptoms(Map<String, bool> data) {
    int sumfactors = 0;
    this.booleanfactors.forEach((key, value) {
      sumfactors += value ? 1 : 0;
    });

    if (this.booleanfactors["krisenregion"] && sumfactors >= 2) return 1;
    if (sumfactors >= 3) return 1;
    return 0;
  }
}
