import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginScreen.dart';
import 'FrontScreen.dart';
import 'Models/Config.dart';

void main() => runApp(new CottageApp());

class CottageApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    Future<String> loadUsername() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('username');
    }

    Future<Config> loadAsset() async {
      var stringConf = await rootBundle.loadString('assets/config.json');
      return Config.fromJson(json.decode((stringConf)));
    }

    return new MaterialApp(
      title: 'Marabo',
      theme: new ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: new FutureBuilder(
        future: loadAsset(),
        builder: (context, config){
          if(config.hasData){
            return new FutureBuilder(
            future: loadUsername(),
                builder: (context, username){
                  if(username.data != null){
                    return new FrontScreen(config.data);
                  }
                  return new LoginScreen(config.data);
              }
            );
          }
          return new CircularProgressIndicator();
        },
      )
    );
  }
}