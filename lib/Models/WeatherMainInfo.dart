class WeatherMainInfo {
  final double temp;
  final double pressure;
  final int humidity;
  final double tempMin;
  final double tempMax;
  final double seaLevel;
  final double grndLevel;

  WeatherMainInfo({
    this.temp,
    this.pressure,
    this.humidity,
    this.tempMin,
    this.tempMax,
    this.seaLevel,
    this.grndLevel
  });

  factory WeatherMainInfo.fromJson(Map<String, dynamic> json){
    return new WeatherMainInfo(
      temp: json['temp'],
      pressure: json['pressure'],
      humidity: json['humidity'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
    );
  }

}