class WindInformation {
  final double speed;
  final double deg;

  WindInformation({this.speed, this.deg});

  factory WindInformation.fromJson(Map<String, dynamic> json){
    return new WindInformation(
      speed: json['speed'],
      deg: json['deg']
    );
  }

}
