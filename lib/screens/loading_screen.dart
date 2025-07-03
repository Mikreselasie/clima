import 'dart:convert';
import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiKey = '12d35787f3ea5dfd1cabfa2289457b11';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    try {
      Location location = Location();
      await location.getCurrentLocation();

      if (location.latitude == null || location.longitude == null) {
        print('Location is not available.');
        return;
      }

      latitude = location.latitude;
      longitude = location.longitude;

      await getWeatherData(latitude!, longitude!);
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> getWeatherData(double latitude, double longitude) async {
    try {
      var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric',
      );

      print('Requesting weather from: $url');

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double temperature = decodedData['main']['temp'];
        String cityName = decodedData['name'];
        int condition = decodedData['weather'][0]['id'];
        print('Temp: $temperature °C, City: $cityName, Condition: $condition');
      } else {
        print('Failed to fetch weather data: [33m${response.statusCode}[0m');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Loading...")));
  }
}
