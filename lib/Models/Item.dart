class Item {
  final String name;
  Item({this.name});

  factory Item.fromJson(Map<String, dynamic> json){
    return new Item(
        name: json['name']
    );
  }
}
