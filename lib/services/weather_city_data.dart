import 'dart:convert';

WeatherCityData? weatherCityFromJson(String str) =>
    WeatherCityData?.fromJson(json.decode(str));

class WeatherCityData {
  final String? city;
  final dynamic temp;
  final dynamic tempMin;
  final dynamic tempMax;
  final dynamic humidity;
  final dynamic wind;
  final int? code;
  // final dynamic description;

  WeatherCityData({
    required this.city,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.wind,
    required this.code,
    // required this.description,
  });

  factory WeatherCityData.fromJson(Map<String, dynamic> json) =>
      WeatherCityData(
        city: json["name"],
        temp: double.parse(json['main']["temp"].toString()).toInt(),
        tempMin: double.parse(json['main']["temp_min"].toString()).toInt(),
        tempMax: double.parse(json['main']["temp_max"].toString()).toInt(),
        humidity: json['main']['humidity'],
        wind: double.parse(json['wind']['speed'].toString()).toInt(),
        code: json['code'],
        // description: json['weather']['description'],
      );
}
