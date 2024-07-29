

import 'package:weather_app/models/clouds.dart';
import 'package:weather_app/models/coord.dart';
import 'package:weather_app/models/daily.dart';
import 'package:weather_app/models/daily_units.dart';
import 'package:weather_app/models/main.dart';
import 'package:weather_app/models/nameInfo.dart';
import 'package:weather_app/models/weatherInfo.dart';
import 'package:weather_app/models/wind.dart';

class WeatherData {
  final WeatherInfo weathers;
  final Wind wind;
  final Clouds clouds;
  final Coord coords;
  final Main mains;
  final NameInfo names;


  const WeatherData({required this.weathers, required this.wind, required this.clouds, required this.coords, required this.mains, required this.names,});


}

