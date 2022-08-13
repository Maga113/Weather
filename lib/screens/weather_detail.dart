// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, library_private_types_in_public_api, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:weather/services/weather_city_data.dart';
import '../services/api_client.dart';
import 'home_screen.dart';

class WeatherDetail extends StatelessWidget {
  final String? city;
  String? errorText = null;
  final ApiClient _apiClient = ApiClient();
  WeatherDetail({Key? key, this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeatherCityData? _weatherhumidity;
    Future<dynamic> humiditydata() async {
      final response = await _apiClient.getCurrentWeather(city);
      _weatherhumidity = response;
      return _weatherhumidity!.humidity;
    }

    WeatherCityData? maxtemperature;
    Future<dynamic> maxtemp() async {
      final response = await _apiClient.getCurrentWeather(city);
      maxtemperature = response;
      return maxtemperature!.tempMax;
    }

    WeatherCityData? _weathertempmin;
    Future<dynamic> minimumTemperature() async {
      final response = await _apiClient.getCurrentWeather(city);
      _weathertempmin = response;
      return _weathertempmin!.tempMin;
    }

    WeatherCityData? _speedwind;
    Future<dynamic> windspeed() async {
      final response = await _apiClient.getCurrentWeather(city);
      _speedwind = response;
      return _speedwind!.wind;
    }

      WeatherCityData? _weatherCityData;
  Future<dynamic> weatherInfo() async {
    final response = await _apiClient.getCurrentWeather(city);
    _weatherCityData = response;
    return _weatherCityData!.temp;
  }


    return ScaffoldGradientBackground(
      gradient: backgroundGradient(),
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Color.fromARGB(255, 14, 69, 113),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: AppBarName(),
            ),
            IconButton(
              splashRadius: 20,
              icon: Icon(CupertinoIcons.info_circle_fill),
              iconSize: 30,
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 160,
            width: double.infinity,
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.sunny,
                    size: 150,
                    color: Colors.yellow,
                  ),
                ],
              ),
            ),
          ),
          Text(
            city!,
            style: TextStyle(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
          ),
          Center(
            child: FutureBuilder(
                future: weatherInfo(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!;
                    return Text(
                      '$data°',
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                alignment: Alignment.topLeft,
                child: FutureBuilder(
                    future: humiditydata(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data;
                        return RichText(
                            maxLines: 1,
                            text: TextSpan(
                              text: 'Влажность: $data%',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.overline,
                                  wordSpacing: 235),
                            ));
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                alignment: Alignment.topLeft,
                child: FutureBuilder(
                    future: minimumTemperature(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data;
                        return RichText(
                            text: TextSpan(
                          text: 'Мин.температура: $data°',
                          style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              wordSpacing: 180),
                        ));
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                alignment: Alignment.topLeft,
                child: FutureBuilder(
                    future: maxtemp(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data;
                        return RichText(
                            text: TextSpan(
                          text: 'Макс.температура: $data°',
                          style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              wordSpacing: 170),
                        ));
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              child: Container(
                alignment: Alignment.topLeft,
                child: FutureBuilder(
                    future: windspeed(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data;
                        return RichText(
                            text: TextSpan(
                          text: 'Ветер : $dataм/с',
                          style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              wordSpacing: 265),
                        ));
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  LinearGradient backgroundGradient() {
    return LinearGradient(
        colors: [
          Color.fromARGB(255, 70, 83, 121),
          Color.fromARGB(255, 44, 184, 219),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.8],
        tileMode: TileMode.clamp);
  }
}

class _IconWeather extends StatelessWidget {
  _IconWeather({
    Key? key,
  }) : super(key: key);
  final ApiClient _apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.sunny,
          size: 150,
          color: Colors.yellow,
        ),
      ],
    );
  }
}

