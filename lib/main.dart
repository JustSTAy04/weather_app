import 'package:flutter/material.dart';
import 'package:weather_app/screens/welcome_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Weather App',
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
