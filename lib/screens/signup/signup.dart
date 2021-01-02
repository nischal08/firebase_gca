import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      backgroundColor: Colors.white,
      body: _body(),
    );
  }

  Widget _body() {
    return ListView(
      children: [
        _field(controller: emailController, hintText: "Email"),
        _field(controller: passwordController, hintText: "Password"),
        _field(
            controller: confirmPasswordController,
            hintText: "Confirm Password"),
        _signupButton(),
      ],
    );
  }

  Widget _signupButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        color: Colors.purple,
        onPressed: () {
          if (confirmPasswordController.text == passwordController.text) {
            _signup();
          }
        },
        child: Text(
          "Sign Up",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _field({TextEditingController controller, String hintText}) {
    InputBorder border = OutlineInputBorder();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: border,
            focusedBorder: border,
            isDense: true),
      ),
    );
  }

  _signup() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    Get.back();
  }
}
