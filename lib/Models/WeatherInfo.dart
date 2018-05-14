class WeatherInfo {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherInfo({this.id, this.main, this.description, this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json){
    return new WeatherInfo(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon']
    );
  }

}