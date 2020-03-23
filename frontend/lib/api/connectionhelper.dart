import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ConnectionHelper {
//  static String baseurl = 'http://10.0.2.2:8080';
//  static String baseurl = 'http://188.68.39.161:8080/members';
  static String baseurl = 'https://kaskovi.de:8081';
  static String _regurl = baseurl + '/register';
  static String _getstatusurl = baseurl + '/getstatus';
  static String _updatefcmurl = baseurl + '/updatefcmtoken';
  static String _testposturl = baseurl + '/api/ping';
  static String _testposturldelay = baseurl + '/api/pingdelay';

//  static Future<Map<String, Object>> sendpostrequest(String url, String token,
//      {String pw = "", Map payload, int timeout}) async {
//    if (payload == null) payload = {};
//    String body = jsonEncode(payload);
//    var result = {"status": 400, "data": ""};
//    String credentials = '$token:$pw';
//    http.Response regresponse;
//    try {
//      var regresponsefuture = http.post(url, body: body, headers: {
//        'Content-type': 'application/json',
//        HttpHeaders.authorizationHeader:
//            "Basic ${base64.encode(utf8.encode(credentials))}",
//      });
//      if (timeout == null) {
//        regresponse = await regresponsefuture;
//      } else {
//        Future<http.Response> fallbackfuture =
//            Future.delayed(Duration(seconds: 3), () {
//          return http.Response(jsonEncode({"status": 400, "data": ""}), 400);
//        });
//        regresponse = await Future.any([regresponsefuture, fallbackfuture]);
//      }
//
//      result["status"] = regresponse.statusCode;
//      result["data"] = regresponse.body;
//    } catch (e) {}
//    return result;
//  }

  static Future<Map<String, Object>> sendpostrequest(String url,
      {Map payload, int timeout}) async {
    if (payload == null) payload = {};
    String body = jsonEncode(payload);
    print("---Payload ist---\n $body");
    var result = {"status": 400, "data": ""};
    http.Response regresponse;
    try {
      var regresponsefuture = http.post(url, body: body, headers: {
        'Content-type': 'application/json',
      });
      if (timeout == null) {
        regresponse = await regresponsefuture;
      } else {
        Future<http.Response> fallbackfuture =
            Future.delayed(Duration(seconds: 3), () {
          return http.Response(jsonEncode({"status": 400, "data": ""}), 400);
        });
        regresponse = await Future.any([regresponsefuture, fallbackfuture]);
      }

      result["status"] = regresponse.statusCode;
      result["data"] = regresponse.body;
    } catch (e) {}
    return result;
  }

//  static Future<Map<String, Object>> registerOnline_old(
//      String username, String pw) async {
//    Map<String, Object> result = await sendpostrequest(_regurl, username,
//        pw: pw, payload: {"username": username, "password": pw}, timeout: 3);
//    return result;
//  }

  static Future<Map<String, Object>> registerOnline(Map data) async {
    Map<String, Object> result = await sendpostrequest(_regurl,
        payload: {"data": data, "password": data["personaldata"]["password"]},
        timeout: 3);
    return result;
  }

  static Future<Map<String, Object>> getStatus(String id) async {
    Map<String, Object> result = await sendpostrequest(_getstatusurl + "/" + id,
        payload: {}, timeout: 3);
    return result;
  }

  static Future<Map<String, Object>> updateFcmToken(
      String id, String token) async {
    Map<String, Object> result = await sendpostrequest(_updatefcmurl,
        payload: {"fcmtoken": token, "id": id}, timeout: 3);
    return result;
  }
}
