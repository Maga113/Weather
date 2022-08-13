import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/weather_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NewYorkTimes',
      theme: ThemeData(),
      routes: {
        '/screen1': (context) => const HomeScreen(),
        '/screen2': (context) => WeatherDetail(),
      },
      initialRoute: '/screen1',
    );
  }
}
