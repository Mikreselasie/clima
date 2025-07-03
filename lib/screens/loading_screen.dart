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
    getLocationData();
  }

  void getLocationData() async {
    try {
      Location location = Location();
      await location.getCurrentLocation();

      if (location.latitude == null || location.longitude == null) {
        print('Location is not available.');
        return;
      }

      latitude = location.latitude;
      longitude = location.longitude;

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
        print('Failed to fetch weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Loading...")));
  }
}
