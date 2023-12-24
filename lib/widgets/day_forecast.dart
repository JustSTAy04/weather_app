import 'package:flutter/material.dart';
import 'package:weather_app/models/constants.dart';

class DayForecast extends StatelessWidget {
  const DayForecast(
      {super.key,
      required this.index,
      required this.forecast,
      required this.updateWeather});

  final Map forecast;
  final void Function(int index) updateWeather;
  final int index;

  @override
  Widget build(BuildContext context) {
    Constants cons = Constants();

    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.all(10),
          shadowColor: cons.darkPurple.withOpacity(0.5),
        ),
        onPressed: () {
          updateWeather(index);
        },
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  forecast['date'],
                  style: TextStyle(
                      color: cons.darkPurple,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  '${forecast['min_temp'].toString()}°',
                  style: TextStyle(
                      color: cons.lightPurple2,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${forecast['max_temp'].toString()}°',
                  style: TextStyle(
                      color: cons.purple,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                  child: Image.asset(
                    forecast['icon'],
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  forecast['status'],
                  style: TextStyle(
                      color: cons.darkPurple,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
