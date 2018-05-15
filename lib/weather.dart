import 'package:flutter/material.dart';
import 'Models/WeatherResponse.dart';
import 'package:meta/meta.dart';

class WeatherScreen extends StatelessWidget {

  final WeatherResponse response;

  WeatherScreen({Key key, @required this.response}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Weather"),
      ),
      body: new Center(
        child: new Text(response.name),
      ),
    );
  }
}