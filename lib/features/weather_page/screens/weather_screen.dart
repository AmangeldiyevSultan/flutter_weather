import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_weather/features/weather_page/screens/choose_weather.dart';
import 'package:flutter_weather/features/weather_page/services/weather_services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({
    super.key,
  });

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

final GlobalKey<NavigatorState> _scaffoldKey = GlobalKey<NavigatorState>();

int? temperature;
String? cityName;
int? condition;
String? iconCode;
String? description;
bool loading = false;

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final weatherData =
          ModalRoute.of(_scaffoldKey.currentContext!)!.settings.arguments;
      updateUI(weatherData);
    });
  }

  updateUI(weatherData) {
    setState(() {
      double temp = weatherData['main']['temp'];
      condition = weatherData['weather'][0]['id'];
      temperature = temp.toInt();
      cityName = weatherData['name'];
      iconCode = weatherData['weather'][0]['icon'];
      description = weatherData['weather'][0]['description'];
      print(iconCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/moun.jpg'),
                  fit: BoxFit.cover)),
        ),
        if (loading == true)
          const Center(
            child: CircularProgressIndicator(),
          ),
        if (loading == false)
          Container(
            margin: EdgeInsets.symmetric(vertical: 25, horizontal: 8),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () async {
                        loading = true;
                        setState(() {});
                        WeatherServices weatherServices = WeatherServices();
                        var currentLocationWeather =
                            await weatherServices.getCurrentData();
                        updateUI(currentLocationWeather);
                        loading = false;
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.locationArrow,
                        color: Colors.white,
                        size: 28,
                      )),
                  IconButton(
                      onPressed: () async {
                        var weatherDataFromCityPage = await Navigator.pushNamed(
                            context, '/choose-weather');

                        if (weatherDataFromCityPage != null) {
                          updateUI(weatherDataFromCityPage);
                        }
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.city,
                        color: Colors.white,
                        size: 28,
                      )),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          child: Text(
                            cityName.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              child: Text(
                                temperature.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 70,
                                    fontFamily: 'Poppins'),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: NetworkImage(
                                    'http://openweathermap.org/img/wn/${iconCode}.png',
                                    scale: 0.9),
                              )),
                            ),
                          ],
                        ),
                      ],
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        description.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
      ]),
    );
  }
}
