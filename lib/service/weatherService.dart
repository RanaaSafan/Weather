import 'package:dio/dio.dart';
import 'package:weather_app/models/WeatherData.dart';
import 'package:weather_app/models/clouds.dart';
import 'package:weather_app/models/coord.dart';
import 'package:weather_app/models/daily.dart';
import 'package:weather_app/models/daily_units.dart';
import 'package:weather_app/models/main.dart';
import 'package:weather_app/models/nameInfo.dart';
import 'package:weather_app/models/weatherInfo.dart' ;
import 'package:weather_app/models/wind.dart';

class WeatherService {
  final Dio dio = Dio();

  Future<WeatherData> getWeatherByCity(String city) async {
    Response response = await dio.get("https://api.openweathermap.org/data/2.5/weather?q=$city&appid=2ce4aced5e5810b28606a8d93debb8a7");

    Map<String, dynamic> jsonData = response.data;
    List<dynamic> weatherData = jsonData["weather"];

    //String name =city;
    String name =jsonData["name"].toString();
    NameInfo nameInfo = NameInfo(Name: name); // because the WeatherData constructor is expecting a NameInfo object, but you are passing a String for the names parameter.


    Map<String, dynamic> CoordData = jsonData["coord"];
    Coord coordd = Coord(lon: CoordData["lon"].toString(), lat: CoordData["lat"].toString());


    Map<String, dynamic> mainData = jsonData["main"];
    Main main = Main(temp: ((mainData["temp" ] as num )-273).round().toString(), pressure: (mainData["pressure"] as num ).round().toString(),humidity: (mainData["humidity"] as num).round().toString()
        ,min: ((mainData["temp_min"] as num )/10).round().toString(),max: ((mainData["temp_max"] as num )/10).round().toString());

    Map<String, dynamic> WindData = jsonData["wind"];
    Wind wind = Wind(speed: WindData["speed"].toString(),degree: WindData["degree"].toString());

   Map<String, dynamic> cloudData = jsonData["clouds"];
    Clouds clouds = Clouds(all: cloudData["all"].toString());




    WeatherInfo weatherInfo = WeatherInfo(
      mains: weatherData[0]["main"],
      description: weatherData[0]["description"],
      icon: weatherData[0]["icon"],
    );


     return WeatherData(weathers: weatherInfo, wind: wind, clouds: clouds,coords:coordd,mains:main,names: nameInfo );
  }

  Future<Daily> getWeatherForecast(Coord coord)async{
    Response response = await dio.get("https://api.open-meteo.com/v1/forecast?latitude=${coord.lat}&longitude=${coord.lon}&daily=temperature_2m_max");
    Map<String, dynamic> dataForecast = response.data;
    List<dynamic> dailyDataJson = dataForecast["daily"]["temperature_2m_max"];
    List<dynamic> timeDataJson = dataForecast["daily"]["time"];

    return Daily(
      time: timeDataJson,
      temperature_2m_max: dailyDataJson,

    );


   // print(daily_units);


  }

}





