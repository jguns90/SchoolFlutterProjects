import 'package:flutter/material.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  static const String _title = 'Brady Bunch';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    final title = 'Brady Bunch';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: GridView.count(
          //Creates Grid
          crossAxisCount: 3,
          children: <Widget>[
           Image.asset('assets/images/alice.jpg'),
           Image.asset('assets/images/bobby.jpg'),
           Image.asset('assets/images/carol.jpg'),
           Image.asset('assets/images/cindy.jpg'),
           Image.asset('assets/images/greg.jpg'),
           Image.asset('assets/images/jan.jpg'),
           Image.asset('assets/images/marcia.jpg'),
           Image.asset('assets/images/mike.jpg'),
           Image.asset('assets/images/peter.jpg'),
          ],
        ),
            )
    );
  }
}