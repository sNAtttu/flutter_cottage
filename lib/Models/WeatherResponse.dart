import 'dart:core';
import 'Coordinates.dart';
import 'WeatherInfo.dart';
import 'WeatherMainInfo.dart';
import 'WindInformation.dart';
import 'CloudInformation.dart';

class WeatherResponse {
  final int id;
  final int cod;
  final int dt;
  final String name;
  final String base;
  final Coordinates coord;
  final WeatherMainInfo main;
  final WindInformation wind;
  final CloudInformation clouds;
  final WeatherInfo weather;

  WeatherResponse({
    this.id,
    this.cod,
    this.dt,
    this.name,
    this.base,
    this.coord,
    this.main,
    this.wind,
    this.clouds,
    this.weather
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json){

    return new WeatherResponse(
      id: json['id'],
      cod: json['cod'],
      dt: json['dt'],
      name: json['name'],
      base: json['base'],
      coord: Coordinates.fromJson(json['coord']),
      main: WeatherMainInfo.fromJson(json['main']),
      wind: WindInformation.fromJson(json['wind']),
      clouds: CloudInformation.fromJson(json['clouds']),
      weather: WeatherInfo.fromJson(json['weather'][0])
    );
  }

}