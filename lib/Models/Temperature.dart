import 'Imperial.dart';
import 'Metric.dart';

class Temperature {
  final Imperial imperial;
  final Metric metric;

  Temperature({this.imperial, this.metric});

  factory Temperature.fromJson(Map<String, dynamic> json){
    return new Temperature(
      imperial: Imperial.fromJson(json['imperial']),
      metric: Metric.fromJson(json['metric'])
    );
  }
}
