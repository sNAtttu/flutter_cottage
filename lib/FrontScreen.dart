import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'WeatherScreen.dart';
import 'Models/WeatherResponse.dart';
import 'Models/Config.dart';



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
                new Card(
                  child: new ListView.builder(
                      itemBuilder: (context, index)  => new EntryItem(data[index]),
                      itemCount: data.length,
                      shrinkWrap: true)),
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
                            onPressed: () => fetchWeather("${config.devUrl}WeatherCondition")),
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
        }),
      )
    );
  }
}
// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  new Entry(
    'Chapter A',
    <Entry>[
      new Entry('Section A1'),
      new Entry('Section A2'),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return new ListTile(title: new Text(root.title));
    return new ExpansionTile(
      key: new PageStorageKey<Entry>(root),
      title: new Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}