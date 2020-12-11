import 'package:flutter/material.dart';
import 'dart:async';





void main() => runApp(MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Interactive StreamBuilder';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}


class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This class controls my forloop and Int Stream
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Stream<int> _myInts = (() async* {
    for (int i = 1; i <= 10; i++) {
      await Future<void>.delayed(Duration(seconds: 1));
      yield i;
    }
  })();

  //This widget takes takes a StreamBuilder and Stream of my Ints 
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2,
      textAlign: TextAlign.center,
      child: Container(
        alignment: FractionalOffset.center,
        color: Colors.white,
        //StreamBuilder and Int Stream
        child: StreamBuilder<int>(
          stream: _myInts,
          //AsynSnapshot captures data
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            List<Widget> children;
            if (snapshot.hasError) {
              children = <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
              //App goes through various states depending on snapshot state
            } else {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  children = <Widget>[
                    Icon(
                      Icons.info,
                      color: Colors.blue,
                      size: 60,
                    ),
                  ];
                  break;
                case ConnectionState.waiting:
                  children = <Widget>[
                    SizedBox(
                      child: Text('Getting Numbers'),
                    )
                  ];
                  break;
                case ConnectionState.active:
                  children = <Widget>[
                   Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('${snapshot.data}'),
                    )
                  ];
                  break;
                case ConnectionState.done:
                  children = <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('${snapshot.data}'),
                    )
                  ];
                  break;
              }
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            );
          },
        ),
      ),
    );
  }
}




