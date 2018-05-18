import 'dart:core';
import 'Temperature.dart';

class WeatherResponse {
  final String localObservationDateTime;
  final int epochTime;
  final String weatherText;
  final int weatherIcon;
  final bool isDayTime;
  final Temperature temperature;
  final String mobileLink;
  final String link;

  WeatherResponse({
    this.localObservationDateTime,
    this.epochTime,
    this.weatherText,
    this.weatherIcon,
    this.isDayTime,
    this.temperature,
    this.mobileLink,
    this.link,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json){

    return new WeatherResponse(
      localObservationDateTime: json['localObservationDateTime'],
      epochTime: json['epochTime'],
      weatherText: json['weatherText'],
      weatherIcon: json['weatherIcon'],
      isDayTime: json['isDayTime'],
      temperature: Temperature.fromJson(json['temperature']),
      mobileLink: json['mobileLink'],
      link: json['link'],
    );
  }

}