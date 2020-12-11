import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
 
void main() {
  runApp(
    MaterialApp(
      title: 'File and IO Assignment',
      home: MyApp(storage: MyString()),
    ),
  );
}
 
//This Class sets up my string path and futures
class MyString {
  //sets up my future
  Future<String> get _mypath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
 //sets up my path
  Future<File> get _myFile async {
    final path = await _mypath;
    return File('$path/text.txt');
  }
 //Reads the file
  Future<String> readFile() async {
    try {
      final file = await _myFile;
      String filetxt = await file.readAsString();
      return filetxt;
    } catch (e) {
      return '';
    }
  }
 //Writing to the file
  Future<File> writeFile(String text) async {
    final file = await _myFile;
    return file.writeAsString('$text\r\n', mode: FileMode.append);
  }
}
 //Sets up main widget
class MyApp extends StatefulWidget {
  final MyString storage;
  MyApp({Key key, @required this.storage}) : super(key: key);
 
  @override
  _MyAppState createState() => _MyAppState();
}
 
class _MyAppState extends State<MyApp> {
  TextEditingController _myinput = new TextEditingController();
 
  String _mystring = '';
 
  @override
  void initState() {
    super.initState();
    widget.storage.readFile().then((String text) {
      setState(() {
        _mystring = text;
      });
    });
  }
  //Formats string Layout in file and sets state
  Future<File> _writefile(String text) async {
    setState(() {
      _mystring  += text+ '\n';
    });
 
    return widget.storage.writeFile(text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File and IO Project'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _myinput,
            ),
            Padding(
              padding: EdgeInsets.all(30.0),

              //RaisedButton Inputs Text
              child: RaisedButton(
                child: Text('Write to File'),
                onPressed: () {
                  if (_myinput.text.isNotEmpty) {
                    _writefile(_myinput.text);
                    _myinput.clear();
                  }
                },
              ),
            ),
            
            Expanded(
                  child: Text(
                  '$_mystring',
                  style: TextStyle(
                   fontSize: 25.0,
                  ),
               ),
              ),
          ],
        ),
      ),
    );
  }
}