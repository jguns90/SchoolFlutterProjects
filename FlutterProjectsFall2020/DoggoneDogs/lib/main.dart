import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DoggoneDogsApp',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: 'DoggoneDogsApp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyDogHomePageState createState() => _MyDogHomePageState();

}

//
class _MyDogHomePageState extends State<MyHomePage> {
  
  //This button should play a barking soundclip upon press
  void _barkbutton() {
    AudioPlayer audioPlayer = AudioPlayer();
    Future<AudioPlayer> playLocalAsset() async {
    AudioCache cache = new AudioCache();
    return await cache.play("barking.mp3");
}
  }
  //This code recieves images from API Endpoint
final String dogpics = 'https://dog.ceo/api/breeds/image/random/100';
  Future<List<String>> fetchDogs() async {
  final List<String> Mydogs = List<String>();
  final Response webresponse = await http.get(dogpics);
  final Map<String, dynamic> jsonResponse = json.decode(webresponse.body);
  jsonResponse['message'].forEach((dogpics) => Mydogs.add(dogpics));
  return Mydogs;
  }
  //Setting up my Widget
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DoggoneDoggiess',
      home: Scaffold(
        appBar: AppBar(title: Text('DoggoneDoggiesApp')),
        //This code takes snapshots of my dog images
        body: FutureBuilder(
          future: fetchDogs(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
           switch (snapshot.connectionState) {
             case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
              //Displays images
              return ListView.builder(
                itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Image(
                        image: NetworkImage(snapshot.data[index]),
                      ),
                    );
                  },
                );
            }
          },
      ),
      //This button calls my dog barking button feature
      floatingActionButton: FloatingActionButton(
        onPressed: _barkbutton,
        tooltip: 'New Feature',
        child: Icon(Icons.add),
      ), 
    )
    );
  }
}
