import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  void initState() {
    // TODO: implement initState
    _configFCM();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                elevation: 4,
                color: CupertinoColors.white,
                onPressed: () {
                  _sendNotification();
                },
                child: Text(
                  "Send test notification",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _sendNotification() async {
    await Future.delayed(Duration(seconds: 5));
    FirebaseMessaging fcm = FirebaseMessaging();
    String serverToken =
        "AAAAFzKEF9E:APA91bFYKHnWm8Urzu-jq6vai6bunDVq22JrZhq9SjeW4sHqf-do7SkIV0R8Jtgidakshp2UOicYLlxEgHQ9CZ2PywJhz6MBBV1ZwcdlcXjYDj9ZX_e1xdHvbQIxtgIKx-hXldJb9Hgb";
    String url = 'https://fcm.googleapis.com/fcm/send';
    Map<String, String> header = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    };

    await post(
      url,
      headers: header,
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'this is a body',
            'title': 'this is a title'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': await fcm.getToken(),
        },
      ),
    );
  }

  _configFCM() async {
    FirebaseMessaging fcm = FirebaseMessaging();
    // String deviceToken = await fcm.getToken(); //To get device token for firstbase console

    fcm.configure(onMessage: (message) {
      _handleOnMessage(message);
    }, onResume: (message) {
      print(message);
    });
  }

  _handleOnMessage(message) {
    Get.dialog(AlertDialog(
      title: Text(message['notification']['title']),
      content: Text(message.toString()),
    ));
  }
}
