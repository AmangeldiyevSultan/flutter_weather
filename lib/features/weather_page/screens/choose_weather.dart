import 'package:flutter/material.dart';
import 'package:flutter_weather/features/weather_page/services/weather_services.dart';

class ChooseWeather extends StatefulWidget {
  const ChooseWeather({super.key});

  @override
  State<ChooseWeather> createState() => _ChooseWeatherState();
}

class _ChooseWeatherState extends State<ChooseWeather> {
  String? text;

  @override
  void dispose() {
    super.dispose();
    text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/moun.jpg'),
                fit: BoxFit.cover)),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
            child: TextField(
              onChanged: ((value) {
                text = value;
                print(text);
              }),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Choose city',
              ),
              style:
                  const TextStyle(fontFamily: 'Poppins', color: Colors.white),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 10, right: 30),
                  width: 120,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        WeatherServices weatherServices = WeatherServices();
                        if (text != null) {
                          var weatherData =
                              await weatherServices.getCityCurrentData(text!);
                          if (weatherData == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Please write city in correct way')));
                          } else {
                            Navigator.pop(context, weatherData);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Please write city in correct way')));
                        }
                      },
                      child: const Text('Submit'))),
            ],
          )
        ]),
      ),
    );
  }
}
