class Metric {
  final double value;
  final String unit;
  final int unitType;

  Metric({this.value, this.unit, this.unitType});

  factory Metric.fromJson(Map<String, dynamic> json){
    return new Metric(
        value: json['value'],
        unit: json['unit'],
        unitType: json['unitType']
    );
  }
}