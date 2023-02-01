import 'package:flutter/material.dart';
import 'package:flutter_weather/features/weather_page/screens/weather_screen.dart';
import 'package:flutter_weather/features/weather_page/services/weather_services.dart';

class WeatherLoadingScreen extends StatefulWidget {
  const WeatherLoadingScreen({super.key});

  @override
  State<WeatherLoadingScreen> createState() => _WeatherLoadingScreenState();
}

int? temperature;
String? cityName;
var weatherData;

class _WeatherLoadingScreenState extends State<WeatherLoadingScreen> {
  void getCurrentData() async {
    try {
      WeatherServices weatherServices = WeatherServices();
      weatherData = await weatherServices.getCurrentData();
      await Navigator.of(context)
          .pushNamed('/weather-screen', arguments: weatherData);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/moun.jpg',
                  ),
                  fit: BoxFit.cover)),
          child: const Center(child: CircularProgressIndicator())),
    );
  }
}
