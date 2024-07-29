import 'package:flutter/material.dart';
import 'package:weather_app/screens/splashScreen.dart';
import 'package:weather_app/service/weatherService.dart';

void main() {
 // WeatherService().getWeatherByCity("cairo");
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home:SplashScreen(),


    );
  }
}
