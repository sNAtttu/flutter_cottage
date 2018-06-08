import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Models/Config.dart';
import '../Models/Entry.dart';

class ItemListCard extends StatelessWidget{
  final Config config;
  ItemListCard(this.config);
  @override
  Widget build(BuildContext context) {
    return new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListView.builder(
                itemBuilder: (context, index)  => new ItemListWidget(this.config),
                itemCount: 1,
                shrinkWrap: true),
            new Row(
              children: <Widget>[
                new Expanded(child: new RaisedButton(
                  onPressed: () => print("Add List Item"),
                  color: Colors.blueGrey,
                  child: new Text("Add item"),
                  textColor: Colors.white,
                ))
              ],
              mainAxisSize: MainAxisSize.max,

            )
          ],
        )
    );
  }

}