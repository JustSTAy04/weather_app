import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/models/constants.dart';
import 'package:weather_app/widgets/weather_detail.dart';
import 'package:weather_app/widgets/hour_forecast.dart';
import 'package:weather_app/screens/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();

  static String apiKey = '69127c0c0b9e438d9be163633232112';
  static String location = 'Kyiv'; // start location
  String weatherIcon = 'rain.png'; // start icon
  double temperature = 0;
  double windSpeed = 0;
  int humidity = 0;
  int cloud = 0;
  int isDay = 1;
  String currentDate = '';
  String currentTime = '';
  String currentWeatherStatus = '';
  List hourlyForecast = [];
  List dailyForecast = [];
  String weatherAPI =
      'http://api.weatherapi.com/v1/forecast.json?key=$apiKey&days=7&aqi=no&q=';

  void getWeatherData(String searchLocation) async {
    try {
      var result = await http.get(Uri.parse(weatherAPI + searchLocation));
      final weatherData =
          Map<String, dynamic>.from(jsonDecode(result.body) ?? 'No data');

      var locationData = weatherData['location'];
      var currentWeather = weatherData['current'];

      setState(() {
        location = locationData['name'];

        updateDate(locationData);
        updateWeather(currentWeather);

        dailyForecast = weatherData['forecast']['forecastday'];
        hourlyForecast = dailyForecast[0]['hour'];
      });
    } catch (e) {}
  }

  void updateDate(locationData) {
    var parsedDate = DateTime.parse(locationData['localtime'].substring(0, 10));
    currentDate = DateFormat('MMMMEEEEd').format(parsedDate);
    currentTime = locationData['localtime'].substring(11, 16);
  }

  void updateWeather(currentWeather) {
    temperature = currentWeather['temp_c'];
    windSpeed = currentWeather['wind_kph'];
    humidity = currentWeather['humidity'];
    cloud = currentWeather['cloud'];
    isDay = currentWeather['is_day'];
    currentWeatherStatus = currentWeather['condition']['text'];
    weatherIcon = changeIcon(currentWeatherStatus);
  }

  String changeIcon(currentStatus) {
    String status = currentStatus.replaceAll(' ', '').toLowerCase();
    if (status == 'fog' && isDay == 1 || status == 'mist' && isDay == 1) {
      return 'mist.png';
    }
    if (status == 'fog' && isDay == 0 || status == 'mist' && isDay == 0) {
      return 'fog.png';
    }
    if (status == 'partlycloudy' && isDay == 1) {
      return 'partlycloudyday.png';
    }
    if (status == 'partlycloudy' && isDay == 0) {
      return 'partlycloudynight.png';
    }
    if (status == 'heavyrain' ||
        status == 'lightrain' ||
        status == 'moderaterain' ||
        status == 'cloudy') {
      return '$status.png';
    }
    if (status.contains('drizzle')) {
      return 'rain.png';
    }
    if (status.contains('freezingrain')) {
      return 'hail.png';
    }
    if (status.contains('rain')) {
      return 'rain.png';
    }
    if (status.contains('snow')) {
      return 'snow.png';
    }
    if (status.contains('sleet')) {
      return 'sleet.png';
    }
    if (status == 'overcast') {
      return 'cloudy.png';
    }
    return '$status.png';
  }

  @override
  void initState() {
    getWeatherData(location);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Constants cons = Constants();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(
          top: 70,
          left: 10,
          right: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: 600,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: cons.darkPurple.withOpacity(.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
                gradient: cons.linearGradient,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/geo.png',
                        width: 28,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        location,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _cityController.clear();
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 70,
                                horizontal: 20,
                              ),
                              child: Column(
                                children: [
                                  TextField(
                                    onChanged: (text) {
                                      getWeatherData(text);
                                    },
                                    controller: _cityController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: cons.darkPurple,
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          _cityController.clear();
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.arrow_right_alt_sharp,
                                          color: cons.darkPurple,
                                        ),
                                      ),
                                      hintText: 'Enter a city...',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Text(
                    currentTime,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(
                    height: 250,
                    child: Image.asset(
                      'assets/$weatherIcon',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Text(
                    '$temperature°',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    currentWeatherStatus,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    currentDate,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      WeatherDetail(
                          value: windSpeed.toInt(),
                          type: 'km/h',
                          image: 'wind'),
                      WeatherDetail(
                          value: humidity, type: '%', image: 'humidity'),
                      WeatherDetail(value: cloud, type: '%', image: 'cloud'),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child: Row(
                children: [
                  Text(
                    'Today',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: cons.darkPurple,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          forecast: dailyForecast,
                          changeIcon: changeIcon,
                        ),
                      ),
                    ),
                    child: Text(
                      '7Days',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: cons.purple,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 140,
              child: ListView.builder(
                itemCount: hourlyForecast.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (ctx, index) {
                  String currentHour = currentTime.substring(0, 2);
                  return HourForecast(
                    currentHour: currentHour,
                    forecast: hourlyForecast[index],
                    changeIcon: changeIcon,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
