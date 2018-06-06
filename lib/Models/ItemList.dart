import 'User.dart';
import 'Item.dart';

class ItemList {
  final int id;
  final String name;
  final User owner;
  final List<Item> items;

  ItemList({this.name, this.owner, this.items, this.id});

  factory ItemList.fromJson(Map<String, dynamic> jsonObject){
    List<Item> tempItems = new List<Item>();
    jsonObject["items"].forEach((item) => tempItems.add(Item.fromJson(item)));
    return new ItemList(
      id: jsonObject["id"],
      items: tempItems,
      name: jsonObject["name"],
      owner: User.fromJson(jsonObject["owner"])
    );
  }

}