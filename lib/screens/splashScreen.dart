import 'package:flutter/material.dart';
import 'package:weather_app/screens/screen1.dart';


class SplashScreen extends StatelessWidget {

  // Removed Daily parameter as it should not be required here
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          Image.asset(
            'assets/spalsh.jpeg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 100,  // Adjust position as needed
            right: 170,  // Adjust position as needed
            child: Center(
              child: ElevatedButton(

                onPressed: () {
                  // Ensure to pass a valid Daily object if needed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Screen1(), // Pass a default or dummy Daily object
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                  minimumSize: MaterialStateProperty.all<Size>(Size(150, 70)),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
