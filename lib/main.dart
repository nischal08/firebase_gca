import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_gca/sqlite/sqliteExample.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue, systemNavigationBarColor: Colors.blue));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _createDatabase();

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SqliteExample(),
    );
  }

  _createDatabase() async {
    String databasePath = await getDatabasesPath();
    String databaseFileName = "my_db.db";
    int databaseVersion = 1;
    openDatabase(databasePath + "/" + databaseFileName,
        version: databaseVersion, onCreate: (db, version) {
      String createTableQuery =
          "CREATE TABLE user(id INTEGER,firstname TEXT,lastname TEXT)";
      db.execute(createTableQuery);
    }, onUpgrade: (db, oldV, newV) {});
  }
}
