import 'dart:async';
import 'dart:convert';
import 'Config.dart';
import 'ItemList.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemListWidget extends StatefulWidget {
  ItemListWidget(this.config);
  final Config config;

  @override
  State<StatefulWidget> createState() => new EntryItem();
}

class EntryItem extends State<ItemListWidget> {

  ItemList itemList;

  Future<ItemList> fetchItemList(String url) async {
    try{
      var response = await http.get(url,
          headers: {"Content-Type": "application/json"});
      return ItemList.fromJson(json.decode(response.body)[0]);
    }
    catch(e){
      print("Failed to deserialize item list: " + e);
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<ItemList>(
      future: fetchItemList("${widget.config.devUrl}ItemLists"),
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
}