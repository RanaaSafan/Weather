import 'package:flutter/material.dart';

import '../models/weatherData.dart';
import '../models/daily.dart';
import '../service/weatherService.dart';
import '../widgets/home_weather.dart';
import '../widgets/weather_tile.dart';

class Screen1 extends StatefulWidget {
  Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final TextEditingController _searchController = TextEditingController();
  late WeatherService weatherService;
  WeatherData? weatherData;
  Daily? dailyData;

  @override
  void initState() {
    super.initState();
    weatherService = WeatherService();
    _fetchWeatherData('cairo');
  }

  Future<void> _fetchWeatherData(String searchText) async {
    try {
      final weatherData = await weatherService.getWeatherByCity(searchText);
      final daily = await weatherService.getWeatherForecast(weatherData!.coords);
      setState(() {
       // this.weatherData = weatherData;
        this.dailyData = daily;
      });
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: SizedBox(
                height: 420,
                width: 380,
                child: HomeWeather(
                  onSearch: (value) {
                    _fetchWeatherData(value);
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: dailyData == null
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dailyData!.temperature_2m_max.length,
                itemBuilder: (context, index) {
                  return WeatherTile(
                    temperature: dailyData!.temperature_2m_max[index],
                    time: dailyData!.time[index].toString(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
