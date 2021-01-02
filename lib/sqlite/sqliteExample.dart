import 'package:flutter/material.dart';

class SqliteExample extends StatefulWidget {
  @override
  _SqliteExampleState createState() => _SqliteExampleState();
}

class _SqliteExampleState extends State<SqliteExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sqflite example"),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Container();
  }
}
