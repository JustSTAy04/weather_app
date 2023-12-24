import 'package:flutter/material.dart';

class WeatherDetail extends StatelessWidget {
  const WeatherDetail(
      {super.key,
      required this.value,
      required this.type,
      required this.image});

  final String type;
  final int value;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/$image.png',
          width: 48,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          '$value$type',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
