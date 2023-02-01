import 'package:flutter/material.dart';
import 'package:flutter_weather/features/weather_page/screens/choose_weather.dart';
import 'package:flutter_weather/features/weather_page/screens/weather_loading.dart';
import 'package:flutter_weather/features/weather_page/screens/weather_screen.dart';
import 'package:flutter_config/flutter_config.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const WeatherLoadingScreen(),
        '/choose-weather': (context) => const ChooseWeather(),
        '/weather-screen': (context) => const WeatherScreen(),
      },
    );
  }
}
