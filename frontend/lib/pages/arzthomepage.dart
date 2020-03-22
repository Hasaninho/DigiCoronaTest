import 'package:digicoronatest/api/connectionhelper.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class Arzthomepage extends StatefulWidget {
  Arzthomepage({Key key}) : super(key: key);

  @override
  _ArzthomepageState createState() => _ArzthomepageState();
}

class _ArzthomepageState extends State<Arzthomepage> {
  String id = "";
  Map<String, dynamic> wholedata = {};
  int ownstatus = 0;
  Map personaldata = {};
  List<dynamic> doctordata = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: id == ""
            ? Center(
                child: MaterialButton(
                    color: Colors.lightGreenAccent,
                    child: Text(
                      "Patient hinzufügen",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: _scan),
              )
            : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[Text("Vorname"), Text("Max")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[Text("Nachname"), Text("Mustermann")],
                    )
                  ],
                ),
              ));
  }

  Future _scan() async {
    print("starting scanner");
    String barcode = await scanner.scan();
//    id = barcode;
    setState(() {
      print("setze ID AUF $barcode");
      this.id = barcode;
    });
    print("finishing scan");
  }

  Future<void> pullData() async {
    print("pulldata2");
//    Map result = await ConnectionHelper.getStatus(id);
//    if (result["status"] != 200) {
//      Fluttertoast.showToast(
//          msg: "Konnte keine Daten ziehen",
//          toastLength: Toast.LENGTH_LONG,
//          gravity: ToastGravity.CENTER,
//          timeInSecForIos: 1,
//          backgroundColor: Colors.green,
//          textColor: Colors.white,
//          fontSize: 16.0);
//      return;
//    }
//    print("result ready");
//    String resultdict_raw = jsonDecode(result["data"])["data"];
//    Map resultdict = jsonDecode(resultdict_raw);
//    setState(() {
////      ownstatus = resultdict["should_check"];
//      personaldata = resultdict["personaldata"];
//      doctordata = resultdict["doctordata"].toList();
//      wholedata = resultdict;
//    });
//  }
  }
}
