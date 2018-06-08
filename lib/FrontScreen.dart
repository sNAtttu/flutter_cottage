import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'WeatherScreen.dart';
import 'Models/WeatherResponse.dart';
import 'Models/Config.dart';
import 'Components/ItemlistCard.dart';
import 'Components/WeatherCard.dart';


class FrontScreen extends StatelessWidget {

  final Config config;

  FrontScreen(this.config);

  removeUsername() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
  }

  Future<WeatherResponse> fetchWeather(String url) async {
    var response = await http.get(url,
        headers: {"Content-Type": "application/json"});
    return WeatherResponse.fromJson(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Cottage"),
      ),
      body: new Center(
      child:
      new FutureBuilder<WeatherResponse>(
        future: fetchWeather("${config.devUrl}WeatherCondition"),
        builder: (weatherContext, weatherResponse) {
          if (weatherResponse.hasData) {
            return new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new ItemListCard(this.config),
                new WeatherCard(weatherResponse.data, this.config)
              ],
            );
          } else if (weatherResponse.hasError) {
            return new Text("${weatherResponse.error}");
          }
          // By default, show a loading spinner
          return new CircularProgressIndicator();
        }),
      )
    );
  }
}


