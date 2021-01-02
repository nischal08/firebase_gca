import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController fieldController = TextEditingController();
  String fileName = "Sample.txt";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Handling"),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [_field(), _saveBtn(), _readBtn(), _saveImage(), _readImage()],
    );
  }

  Widget _saveBtn() {
    return MaterialButton(
      onPressed: () {
        _fileWrite();
      },
      minWidth: double.infinity,
      color: Colors.green,
      child: Text("Save as a file"),
    );
  }

  Widget _saveImage() {
    return MaterialButton(
      color: Colors.white70,
      onPressed: () {
        String imgUrl =
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/How_to_use_icon.svg/1200px-How_to_use_icon.svg.png";
        Image img = Image.network(imgUrl);
      },
      child: Text("Save image as a file"),
    );
  }

  Widget _readImage() {
    return MaterialButton(
      color: Colors.white70,
      onPressed: () {},
      child: Text("Read Image"),
    );
  }

  _fileWrite() async {
    Directory directory = await getApplicationDocumentsDirectory();
    ListFiles(directory);

    String filePath = directory.path + "/" + fileName;
    String fileData = fieldController.text;
    print("writing into file .......\n");
    File file = File(filePath);
    file.writeAsStringSync(fileData);
    print("Finished writing .......\n");
    ListFiles(directory);
    // File(filePath).writeAsStringSync(fileData);
  }

  ListFiles(Directory directory) {
    List<FileSystemEntity> fileList = directory.listSync();
    for (FileSystemEntity each in fileList) {
      print(each.path);
    }
  }

  _fileRead() {
    String filePath =
        "/data/user/0/com.nirajkaranjeet.firebase_gca/app_flutter/Sample.txt";
    File file = File(filePath);
    String readText = file.readAsStringSync();
    print(readText);
  }

  Widget _readBtn() {
    return MaterialButton(
      onPressed: () {
        _fileRead();
      },
      minWidth: double.infinity,
      color: Colors.purple,
      child: Text("Read from the file"),
    );
  }

  Widget _field() {
    return TextField(
      controller: fieldController,
    );
  }
}
