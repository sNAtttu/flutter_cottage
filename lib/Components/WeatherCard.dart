import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../WeatherScreen.dart';
import '../Models/WeatherResponse.dart';
import '../Models/Config.dart';

class WeatherCard extends StatelessWidget{
  final Config config;
  final WeatherResponse weatherResponse;

  WeatherCard(this.weatherResponse, this.config);

  Future<WeatherResponse> fetchWeather(String url) async {
    var response = await http.get(url,
        headers: {"Content-Type": "application/json"});
    return WeatherResponse.fromJson(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: new Icon(Icons.cloud),
            title: new Text(weatherResponse.weatherText),
            subtitle: new Text("Temperature: ${weatherResponse.temperature.metric.value} C"),
            onTap: (){ Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new WeatherScreen(response: weatherResponse))); },
            trailing: new IconButton(icon: new Icon(Icons.refresh),
                onPressed: () => fetchWeather("${config.devUrl}WeatherCondition")),
          )
        ],
      ),
    );
  }

}