import 'package:flutter/material.dart';
import 'FrontScreen.dart';

void main() => runApp(new CottageApp());

class CottageApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Marabo',
      theme: new ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: new FrontScreen(title: 'Marabo'),
    );
  }
}

