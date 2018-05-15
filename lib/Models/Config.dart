class Config {
  final double latitude;
  final double longitude;
  final String units;
  final String appId;
  final String baseUrl;

  Config({this.latitude, this.longitude, this.units, this.appId, this.baseUrl});

  factory Config.fromJson(Map<String, dynamic> json){
    return new Config(
      latitude: json['latitude'],
      longitude: json['longitude'],
      units: json['units'],
      appId: json['appId'],
      baseUrl: json['baseUrl']
    );
  }

}