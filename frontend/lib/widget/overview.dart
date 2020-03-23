import 'dart:convert';
import 'dart:typed_data';

import 'package:digicoronatest/api/connectionhelper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class Overview extends StatefulWidget {
  String token = "";
  Overview(this.token, {Key key}) : super(key: key);

  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> with WidgetsBindingObserver {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  Uint8List bytes = Uint8List(0);
  Map<String, dynamic> wholedata = {};
  int ownstatus = 0;
  Map personaldata = {};
  List<dynamic> doctordata = [];
  List<bool> selectstatus = [false, false];
  AppLifecycleState _notification;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    pullData();
    setState(() {
      _notification = state;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    pullData();
    _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
    _firebaseMessaging.getToken();

    _firebaseMessaging.subscribeToTopic('all');

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage:");
        pullData();
//        print("onMessage: $message");
        final notification = message['notification'];
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch:");
        pullData();
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume:");
        pullData();
//        messages.add(Message(title: "onResume", body: "body"));
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("building");
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 30.0,
              ),
              MaterialButton(
                child: Text("Lösche Daten!"),
                onPressed: () {
                  savetoShared("id", "");
                },
              ),
              MaterialButton(
                color: Colors.blue,
                child: Text("Generiere QR-Token!"),
                onPressed: () {
                  print("creating token");
                  showQR(context);
                },
              ),
//            MaterialButton(
//              child: Text("Get Status!"),
//              onPressed: () async {
//                print("getstatus");
//                pullData();
//              },
//            ),
              Text(
                "Dein Status",
                style: TextStyle(fontSize: 26.0),
              ),
              Container(
                height: 20.0,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.grey),
                    borderRadius: BorderRadius.circular(12)),
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      ownstatus == 0 ? ownstatus = 1 : ownstatus = 0;
                    });
                  },
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        iconSize: 80.0,
                        icon: ownstatus == 0
                            ? Icon(Icons.mood)
                            : Icon(Icons.mood_bad),
                        disabledColor:
                            ownstatus == 0 ? Colors.green : Colors.red,
                      ),
                      Text(
                        ownstatus == 0
                            ? "Du bist gesund!"
                            : "Das Gesundheitsamt meldet\nsich bei dir für\neinen Termin!",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 10.0,
              ),
              Container(
                height: 20,
              ),
              Divider(
                thickness: 2.0,
              ),
              Flexible(
                child: ListView(
                  children: doctordata
                      .map((value) => ListTile(
                            title: value["title"],
                            trailing: value["trailing"],
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendTokenToServer(String event) async {
    print("getting token");
    Map result = await ConnectionHelper.updateFcmToken(widget.token, event);
//    Map result = await ConnectionHelper.updatefcmtoken(widget.token, event);
  }

  Future<void> pullData() async {
    print("pulldata2");
    Map result = await ConnectionHelper.getStatus(widget.token);
    if (result["status"] != 200) {
      Fluttertoast.showToast(
          msg: "Konnte keine Daten ziehen",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    print("result ready");
    String resultdict_raw = jsonDecode(result["data"])["data"];
    Map resultdict = jsonDecode(resultdict_raw);
    print("resultdict is:");
    print(resultdict);
    setState(() {
      ownstatus = resultdict["should_check"];
      personaldata = resultdict["personaldata"];
      doctordata = resultdict["doctordata"].toList();
      wholedata = resultdict;
    });
  }

  void savetoShared(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    print('saved $key and $value');
  }

  Widget statusIcon(int value) {
    double iconsize = 40.0;
    if (value == 1) {
      return Icon(
        Icons.check_box,
        color: Colors.green,
        size: iconsize,
      );
    } else if (value == 2) {
      return Icon(
        Icons.cancel,
        color: Colors.red,
        size: iconsize,
      );
    } else {
      return Icon(
        Icons.device_unknown,
        color: Colors.grey,
        size: iconsize,
      );
    }
  }

  Future<bool> changestatus(int newstatus) async {
    print("starting change");
//    Map<String, Object> result =
//        await ConnectionHelper.updatestatus(widget.token, newstatus);
//    if (result["status"] != 200) {
//      print("couldnt change");
//      Fluttertoast.showToast(
//          msg: "Konnte nicht updaten!",
//          toastLength: Toast.LENGTH_LONG,
//          gravity: ToastGravity.CENTER,
//          timeInSecForIos: 1,
//          backgroundColor: Colors.green,
//          textColor: Colors.white,
//          fontSize: 16.0);
//      return false;
//    }
    return true;
  }

  Future _generateBarCode(String inputCode) async {
    print("generating QC COde ");
    Uint8List result = await scanner.generateBarCode(inputCode);
    this.setState(() => this.bytes = result);
  }

  Future<void> showQR(BuildContext context) async {
    await _generateBarCode(widget.token);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('QR Code'),
          content: Container(child: Image.memory(bytes)),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
