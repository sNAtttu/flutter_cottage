class Imperial {
  final int value;
  final String unit;
  final int unitType;

  Imperial({this.value, this.unit, this.unitType});

  factory Imperial.fromJson(Map<String, dynamic> json){
    return new Imperial(
        value: json['value'],
        unit: json['unit'],
        unitType: json['unitType']
    );
  }

}