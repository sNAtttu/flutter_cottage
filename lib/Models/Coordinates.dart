class Coordinates {
  final double lon;
  final double lat;

  Coordinates({this.lat, this.lon});

  factory Coordinates.fromJson(Map<String, dynamic> json){
    return new Coordinates(
      lon: json['lon'],
      lat: json['lat'],
    );
  }

}