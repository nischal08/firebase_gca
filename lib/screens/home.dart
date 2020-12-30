import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_gca/screens/dataList.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String fetchData = "Empty";
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController _fieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text("Firebase CRUD"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _createButton(),
                _readButton(),
                _deleteButton(),
              ],
            ),
            Text(fetchData),
            _textField(),
            _updateBtn(),
            DataList(),
          ],
        ),
      ),
    );
  }

  Widget _deleteButton() {
    return _btn(
        btnColor: Colors.red,
        onPressed: () {
          _delete();
        },
        btnName: "Delete");
  }

  Widget _updateBtn() {
    return _btn(
        onPressed: () {
          _update();
        },
        btnName: "Update");
  }

  Widget _textField() {
    return TextField(
      controller: _fieldController,
    );
  }

  Widget _readButton() {
    return _btn(
        onPressed: () {
          _read();
        },
        btnName: "Read");
  }

  Widget _btn({btnColor, @required Function onPressed, String btnName}) {
    return MaterialButton(
      onPressed: onPressed,
      color: btnColor ?? Colors.green,
      child: Text(
        btnName,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _createButton() {
    return _btn(
        onPressed: () {
          _create();
        },
        btnName: "Create");
  }

  _delete() async {
    await firestore.collection("users").doc("1").delete();
  }

  _read() async {
    DocumentSnapshot docSnap = await firestore
        .collection("users")
        .doc("1")
        .get(); //This form document level data access
    fetchData = docSnap.data().toString();
    setState(() {});
    // QuerySnapshot querySnapshot = await firestore.collection("users").get();
    // List<QueryDocumentSnapshot> qdocSnapList = querySnapshot.docs; //This form collection level ,all data access
    // for (QueryDocumentSnapshot each in qdocSnapList) {
    //   print(each.data());
    // }
  }

  _update() async {
    await firestore
        .collection("users")
        .doc("1")
        .update({"address": _fieldController.text});
    _fieldController.clear();
  }

  _create() async {
    Map<String, dynamic> data = {
      "email": "user@user.com",
      "phone": "231312xxxxx",
      "age": 30,
      "address": "Kathmandu"
    };
    await firestore
        .collection("users")
        .doc(DateTime.now().toString())
        .set(data); // create database
  }
}
