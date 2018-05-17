import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginScreen.dart';
import 'FrontScreen.dart';

void main() => runApp(new CottageApp());

class CottageApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    Future<String> _loadUsername() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('username');
    }

    return new MaterialApp(
      title: 'Marabo',
      theme: new ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: new FutureBuilder(
        future: _loadUsername(),
        builder: (context, username){
          if(username.data != null){
            return new FrontScreen();
          }
          return new LoginScreen();
        },
      )
    );
  }
}