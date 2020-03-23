import 'dart:convert';

import 'package:digicoronatest/api/connectionhelper.dart';
import 'package:digicoronatest/pages/symptomspage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Map<String, dynamic> _formData = Map();
  final TextEditingController pw2controller = TextEditingController();
  final TextEditingController pwcontroller = TextEditingController(text: "");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: true,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 0.0),
            child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Container(
                      child: Container(
                        child: Text(
                          'Corona Digi Test',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 40.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TextFormField(
                        decoration: buildInputDecoration("Vorname"),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Gib einen gültige Vornamen ein';
                          }
                        },
                        onSaved: (String value) {
                          _formData['firstname'] = value;
                        }),
                    SizedBox(height: 10.0),
                    TextFormField(
                        decoration: buildInputDecoration("Nachname"),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Gib einen gültige Nachnamen ein';
                          }
                        },
                        onSaved: (String value) {
                          _formData['lastname'] = value;
                        }),
                    TextFormField(
                        decoration: buildInputDecoration("Adresse"),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Gib eine gültige Adresse ein ein';
                          }
                        },
                        onSaved: (String value) {
                          _formData['adress'] = value;
                        }),
                    SizedBox(height: 10.0),
                    TextFormField(
                      decoration: buildInputDecoration("Passwort"),
                      controller: pwcontroller,
                      obscureText: true,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Gib ein Passwort ein ein ein';
                        }
                        if (pw2controller.text != pwcontroller.text) {
                          return 'Passwörter stimme nicht überein';
                        }
                      },
                      onSaved: (String value) {
                        _formData['password'] = value;
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      decoration: buildInputDecoration("Passwort wiederholen"),
                      controller: pw2controller,
                      obscureText: true,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Gib eine gültige Adresse ein ein';
                        }
                        if (pw2controller.text != pwcontroller.text) {
                          return 'Passwörter stimme nicht überein';
                        }
                      },
                    ),
                    SizedBox(height: 50.0),
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                      ),
                      color: Colors.green,
                      child: Text("Weiter"),
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          print("net ok");
                          return;
                        }
                        _formKey.currentState.save();
                        print("Data:");
                        print(_formData);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Symptomspage(_formData)));
                      },
                    )
                  ],
                )),
          ),
        ));
  }

  InputDecoration buildInputDecoration(String text) {
    return InputDecoration(
        labelText: text,
        labelStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.grey),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)));
  }

  void savetoShared(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    print('saved $key and $value');
  }
}
