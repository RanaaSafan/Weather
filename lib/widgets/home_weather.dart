import 'package:flutter/material.dart';
import 'package:weather_app/models/WeatherData.dart';
import 'package:weather_app/service/weatherService.dart';
import '../models/daily.dart';

class HomeWeather extends StatefulWidget {
  final Function(String) onSearch;

  HomeWeather({Key? key, required this.onSearch}) : super(key: key);

  @override
  _HomeWeatherState createState() => _HomeWeatherState();
}

class _HomeWeatherState extends State<HomeWeather> {
  final TextEditingController _searchController = TextEditingController();
  late WeatherService weatherService;
  WeatherData? weatherData;

  @override
  void initState() {
    super.initState();
    weatherService = WeatherService();
    _fetchWeatherData('cairo'); // Default location
  }

  Future<void> _fetchWeatherData(String searchText) async {
    try {
      final data = await weatherService.getWeatherByCity(searchText);
      setState(() {
        weatherData = data;
      });
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                onSubmitted: (value) {
                  widget.onSearch(value);
                  _fetchWeatherData(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.deepPurple),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear, color: Colors.deepPurple),
                    onPressed: () {
                      _searchController.clear();
                    },
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.deepPurple, Colors.purple, Colors.purpleAccent],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (weatherData != null)
                    Column(
                      children: [
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 20,
                              color: Colors.purpleAccent,
                            ),
                            Text(
                              "${weatherData!.names.Name}",
                              style: TextStyle(color: Colors.purpleAccent, fontSize: 30),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Image.network(
                          "https://openweathermap.org/img/w/${weatherData!.weathers.icon}.png",
                          height: 70, // Adjust the height as needed
                          width: 150,
                          fit: BoxFit.fitWidth, // Adjust the width as needed
                        ),
                        SizedBox(height: 5),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              " ${weatherData!.mains.temp}",
                              style: TextStyle(color: Colors.deepPurple, fontSize: 60, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "°C",
                              style: TextStyle(color: Colors.deepPurple, fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          "${weatherData!.weathers.description}",
                          style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        if (weatherData != null)
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.air_rounded, color: Colors.black, size: 20),
                  Text("   ${weatherData!.wind.speed} m/s", style: TextStyle(color: Colors.black, fontSize: 15)),
                  Text("               "),
                  Center(child: Icon(Icons.water_drop_outlined, color: Colors.black, size: 20)),
                  Center(child: Text("   ${weatherData!.mains.humidity}%", style: TextStyle(color: Colors.black, fontSize: 15))),
                  Text("           "),
                  Center(child: Icon(Icons.arrow_upward_rounded, color: Colors.black, size: 20)),
                  Center(child: Text("${weatherData!.mains.max}", style: TextStyle(color: Colors.black, fontSize: 15))),
                  Text("  "),
                  Center(child: Icon(Icons.arrow_downward_rounded, color: Colors.black, size: 20)),
                  Center(child: Text("${weatherData!.mains.min}", style: TextStyle(color: Colors.black, fontSize: 15))),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
      ],
    );
  }
}