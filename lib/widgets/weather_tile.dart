import 'package:flutter/material.dart';

class WeatherTile extends StatelessWidget {
  final double temperature;
  final String time;

  WeatherTile({super.key, required this.temperature, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.deepPurple,
                  Colors.purple,
                  Colors.purpleAccent,
                  Colors.white,
                ],
              ),
            ),
            height: 120,
            width: 100,
          ),
          Column(

            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text(
                  time,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              SizedBox(height: 9,),
              Center(
                child: Text(
                  '${temperature.toStringAsFixed(0)}°C',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
