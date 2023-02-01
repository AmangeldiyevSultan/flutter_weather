import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';

class WeatherServices {
  Future<dynamic> getCurrentData() async {
    try {
      Position currentLocation = await Geolocator.getCurrentPosition();
      String api =
          '${Constant.base_url}/data/2.5/weather?lat=${currentLocation.latitude}&lon=${currentLocation.longitude}&appid=${Constant.api_key}&units=metric';
      var weatherData = await _getWeatherData(api);
      return weatherData;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getCityCurrentData(String text) async {
    try {
      String api =
          '${Constant.base_url}/data/2.5/weather?q=$text&appid=${Constant.api_key}&units=metric';
      var weatherData = await _getWeatherData(api);
      return weatherData;
    } catch (e) {
      print(e);
    }
  }

  Future _getWeatherData(String api) async {
    http.Response res = await http.get(Uri.parse(api));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return data;
    } else {
      print(res.statusCode);
    }
  }
}
