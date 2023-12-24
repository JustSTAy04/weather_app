import 'package:weather_app/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/constants.dart';

class HourForecast extends StatelessWidget {
  const HourForecast(
      {super.key,
      required this.currentHour,
      required this.forecast,
      required this.changeIcon});

  final String currentHour;
  final dynamic forecast;
  final String Function(String status) changeIcon;

  @override
  Widget build(BuildContext context) {
    Constants cons = Constants();

    String forecastHour = forecast['time'].substring(11, 13);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.only(right: 20),
      width: 80,
      decoration: BoxDecoration(
          color: forecastHour == currentHour ? cons.darkPurple : cons.anotherPurple,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: cons.darkPurple.withOpacity(0.3),
              offset: const Offset(2, 2),
              blurRadius: 8,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            forecast['time'].substring(11, 16),
            style: TextStyle(
              color:
                  forecastHour == currentHour ? Colors.white : cons.darkPurple,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.asset(
            'assets/${changeIcon(forecast['condition']['text'])}',
            width: 60,
          ),
          Text(
            '${forecast['temp_c'].round().toString()}°',
            style: TextStyle(
              color:
              forecastHour == currentHour ? Colors.white : cons.darkPurple,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
