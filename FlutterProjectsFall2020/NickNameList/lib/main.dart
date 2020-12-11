import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}
class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  //List to hold nicknames
  List<String> nicknames = <String>[];
  
  TextEditingController NicknameControls = TextEditingController();
  //Method that adds nicknames to List
  void addNicknames(){
    setState(() {
      nicknames.insert(0,NicknameControls.text);
    });
  }
  //Creating Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NicknameList'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: NicknameControls,
              decoration: InputDecoration(
                labelText: 'Add NickName',
              ),
            ),
          ),
          //Button calls AddNicknames function
          RaisedButton(
            
            child: Text('Add a name'),
            onPressed: () {
              addNicknames();
            },
          ),
          //Controls Display
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: nicknames.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Center(
                    child: Text('${nicknames[index]}',
                      style: TextStyle(fontSize: 30),
                    )
                  ),
                );
              }
            )
          )
        ]
      )
    );
  }
}