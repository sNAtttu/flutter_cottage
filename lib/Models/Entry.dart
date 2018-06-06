import 'dart:async';
import 'dart:convert';
import 'Item.dart';

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
    throw e;
  }
}

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.config);
  final ItemList itemList;
  final Config config;
  Widget _buildTiles() {
    return new FutureBuilder<ItemList>(
      future: fetchItemList("${config.devUrl}ItemLists"),
      builder: (context, response){
        if(response.hasData){
          return new ExpansionTile(
            key: new PageStorageKey<int>(response.data.id),
            title: new Text(response.data.name),
            children: response.data.items.map((item) => new Text(item.name)).toList(),
          );
        }
        else{
          return new ExpansionTile(
            key: new PageStorageKey<int>(1),
            title: new CircularProgressIndicator(),
            children: null,
          );
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles();
  }
}