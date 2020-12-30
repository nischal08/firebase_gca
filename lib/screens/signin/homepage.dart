import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_gca/screens/signin/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [_signOutButton()],
      ),
    );
  }

  Widget _signOutButton() {
    return IconButton(
        icon: Icon(Icons.power_settings_new),
        onPressed: () {
          _signout();
        });
  }

  _signout() async {
    await FirebaseAuth.instance.signOut();
    Get.off(Signin());
  }
}
