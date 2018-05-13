import 'package:flutter/material.dart';
import 'weather.dart';

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
                   title: new Text("Pilvistä"),
                   subtitle: new Text("15 Astetta"),
                   onTap: (){ Navigator.push(context, new MaterialPageRoute(builder: (context) => new WeatherScreen())); },
                   trailing: new IconButton(icon: new Icon(Icons.refresh),
                     onPressed: () => print("Refresh")),
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
