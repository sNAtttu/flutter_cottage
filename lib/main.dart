import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'weather.dart';
import 'Models/WeatherResponse.dart';

void main() => runApp(new CottageApp());

class CottageApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Cottage'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  WeatherResponse weatherResponse;

  _MyHomePageState(){
    fetchWeather();
  }

  // TODO: Values to configure file.
  // http://api.openweathermap.org/data/2.5/weather?lat=59.941653&lon=23.918724&units=metric&APPID=c5be22a781d7bfc4dd192281dc1150b3

  static double latitude =  59.941653;
  static double longitude = 23.918724;
  static String units = "metric";
  static String appId = "c5be22a781d7bfc4dd192281dc1150b3";
  static String baseUrl = "http://api.openweathermap.org/data/2.5/weather";
  final String url = "$baseUrl?lat=$latitude&lon=$longitude&units=$units&APPID=$appId";

  Future<WeatherResponse> fetchWeather() async {
    final response = await http.get(url);
    final responseJson = json.decode(response.body);
    WeatherResponse weatherResp = WeatherResponse.fromJson(responseJson);
    setState(() {
      weatherResponse = weatherResp;
    });
    return weatherResp;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           new Card(
             child: new Column(
               mainAxisSize: MainAxisSize.min,
               children: <Widget>[
                 ListTile(
                   leading: new Icon(Icons.cloud),
                   title: new Text(weatherResponse.weather.main),
                   subtitle: new Text(weatherResponse.weather.description + " " + weatherResponse.main.temp.toString() + " °C"),
                   onTap: (){ Navigator.push(context,
                       new MaterialPageRoute(builder: (context) => new WeatherScreen())); },
                   trailing: new IconButton(icon: new Icon(Icons.refresh),
                     onPressed: () => fetchWeather()),
                 )
               ],
             ),
           )
          ],
        ),
      ),
    );
  }
}
