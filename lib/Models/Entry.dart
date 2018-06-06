import 'dart:async';
import 'dart:convert';
import 'Config.dart';
import 'ItemList.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// One entry in the multilevel list displayed by this app.
import 'package:flutter/widgets.dart';
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

Future<ItemList> fetchItemList(String url) async {
  try{
    var response = await http.get(url,
        headers: {"Content-Type": "application/json"});
    return ItemList.fromJson(json.decode(response.body)[0]);
  }
  catch(e){
    print(e);
  }
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  new Entry(
    'Stuff left at the Cottage',
    <Entry>[
      new Entry('Section A1'),
      new Entry('Section A2'),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry, this.config);

  final Entry entry;
  final Config config;
  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return new ListTile(title: new Text(root.title));
    return new FutureBuilder<ItemList>(
      future: fetchItemList("${config.devUrl}ItemLists"),
      builder: (context, response){
        if(response.hasData){
          return new ExpansionTile(
            key: new PageStorageKey<Entry>(root),
            title: new Text(response.data.name),
            children: root.children.map(_buildTiles).toList(),
          );
        }
        else{
          return new ExpansionTile(
            key: new PageStorageKey<Entry>(root),
            title: new CircularProgressIndicator(),
            children: root.children.map(_buildTiles).toList(),
          );
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}