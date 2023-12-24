import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/constants.dart';
import 'package:weather_app/widgets/weather_detail.dart';
import 'package:weather_app/widgets/day_forecast.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen(
      {super.key, required this.forecast, required this.changeIcon});

  final List forecast;
  final String Function(String status) changeIcon;

  @override
  State<DetailScreen> createState() => _DetailScreenState(forecast);
}

class _DetailScreenState extends State<DetailScreen> {
  _DetailScreenState(this.forecast);
  final forecast;

  String selectedDate = '';
  String selectedAvgTemp = '';
  int selectedWindSpeed = 0;
  int selectedHumidity = 0;
  String selectedStatus = '';
  String selectedIcon = '';

  @override
  initState() {
    selectedDate =
        DateFormat('MMMMEEEEd').format(DateTime.parse(forecast[0]['date']));
    selectedAvgTemp = forecast[0]['day']['avgtemp_c'].round().toString();
    selectedWindSpeed = forecast[0]['day']['maxwind_kph'].round().toInt();
    selectedHumidity = forecast[0]['day']['avghumidity'].toInt();
    selectedStatus = forecast[0]['day']['condition']['text'];
    selectedIcon = 'assets/${widget.changeIcon(selectedStatus)}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Constants cons = Constants();

    Map getWeather(int index) {
      String status = forecast[index]['day']['condition']['text'];
      return {
        'date': DateFormat('MMMMEEEEd')
            .format(DateTime.parse(forecast[index]['date'])),
        'max_temp': forecast[index]['day']['maxtemp_c'].round(),
        'min_temp': forecast[index]['day']['mintemp_c'].round(),
        'avg_temp': forecast[index]['day']['avgtemp_c'],
        'wind_speed': forecast[index]['day']['maxwind_kph'],
        'humidity': forecast[index]['day']['avghumidity'],
        'status': status,
        'icon': 'assets/${widget.changeIcon(status)}',
      };
    }

    void updateWeather(int index) {
      var data = getWeather(index);
      setState(() {
        selectedDate = data['date'];
        selectedAvgTemp = data['avg_temp'].round().toString();
        selectedWindSpeed = data['wind_speed'].round().toInt();
        selectedHumidity = data['humidity'].toInt();
        selectedStatus = data['status'];
        selectedIcon = data['icon'];
      });
    }

    return Scaffold(
      backgroundColor: cons.lightPurple2,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: cons.lightPurple2,
        centerTitle: true,
        title: const Text(
          '7Days forecast',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: cons.linearGradient2,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: cons.darkPurple.withOpacity(.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              height: 360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    selectedDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '$selectedAvgTemp°',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 170,
                        child: Image.asset(selectedIcon, fit: BoxFit.fitHeight),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        selectedStatus,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      WeatherDetail(
                          value: selectedWindSpeed,
                          type: 'km/h',
                          image: 'wind'),
                      WeatherDetail(
                          value: selectedHumidity, type: '%', image: 'humidity')
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              height: 370,
              child: ListView.builder(
                itemCount: forecast.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (ctx, index) => DayForecast(index: index, forecast: getWeather(index), updateWeather: updateWeather),
              ),
            )
          ],
        ),
      ),
    );
  }
}
