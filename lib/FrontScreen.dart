import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'WeatherScreen.dart';
import 'Models/WeatherResponse.dart';
import 'Models/Config.dart';



class FrontScreen extends StatelessWidget {

  removeUsername() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
  }

  Future<Config> loadAsset() async {
    var stringConf = await rootBundle.loadString('assets/config.json');
    return Config.fromJson(json.decode((stringConf)));
  }

  Future<WeatherResponse> fetchWeather(String url) async {
    var response = await http.get(url,
        headers: {"Content-Type": "application/json"});
    print(response.body);
    return WeatherResponse.fromJson(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(onPressed:
          () => removeUsername()
      ),
      appBar: new AppBar(
        title: new Text("Cottage"),
      ),
      body: new Center(
          child: new FutureBuilder<Config>(
              future: loadAsset(),
              builder: (confContext, config) {
                if (config.hasData && config.connectionState == ConnectionState.done) {
                  return new FutureBuilder<WeatherResponse>(
                    future: fetchWeather("${config.data.devUrl}"),
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
                                    title: new Text(weatherResponse.data.weatherText),
                                    subtitle: new Text("Temperature: ${weatherResponse.data.temperature.metric.value} C"),
                                    onTap: (){ Navigator.push(context,
                                        new MaterialPageRoute(builder: (context) => new WeatherScreen(response: weatherResponse.data))); },
                                    trailing: new IconButton(icon: new Icon(Icons.refresh),
                                        onPressed: () => fetchWeather("${config.data.devUrl}")),
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
