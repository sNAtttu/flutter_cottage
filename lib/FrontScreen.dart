import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'WeatherScreen.dart';
import 'Models/WeatherResponse.dart';
import 'Models/Config.dart';

class FrontScreen extends StatefulWidget {
  FrontScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FrontScreenState createState() => new _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {

  Future<Config> loadAsset() async {
    var stringConf = await rootBundle.loadString('assets/config.json');
    return Config.fromJson(json.decode((stringConf)));
  }

  Future<WeatherResponse> fetchWeather(String url) async {
    var response = await http.get(url);
    return WeatherResponse.fromJson(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
          child: new FutureBuilder<Config>(
              future: loadAsset(),
              builder: (confContext, config) {
                if (config.hasData) {
                  return new FutureBuilder<WeatherResponse>(
                    future: fetchWeather("${config.data.baseUrl}?lat=${config.data.latitude}&lon=${config.data.longitude}&units=${config.data.units}&APPID=${config.data.appId}"),
                    builder: (weatherContext, weatherResponse) {
                      if (weatherResponse.hasData) {
                        return new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Card(
                              child: new Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: new Icon(Icons.cloud),
                                    title: new Text(weatherResponse.data.weather.main),
                                    subtitle: new Text("Temperature: " +
                                        weatherResponse.data.main.temp.round().toString() + " °C"),
                                    onTap: (){ Navigator.push(context,
                                        new MaterialPageRoute(builder: (context) => new WeatherScreen(response: weatherResponse.data))); },
                                    trailing: new IconButton(icon: new Icon(Icons.refresh),
                                        onPressed: () => fetchWeather("${config.data.baseUrl}?lat=${config.data.latitude}&lon=${config.data.longitude}&units=${config.data.units}&APPID=${config.data.appId}")),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      } else if (weatherResponse.hasError) {
                        return new Text("${weatherResponse.error}");
                      }
                      // By default, show a loading spinner
                      return new CircularProgressIndicator();
                    },
                  );
                } else if (config.hasError) {
                  return new Text("${config.error}");
                }
                // By default, show a loading spinner
                return new CircularProgressIndicator();
              }
          )
      ),
    );
  }
}
