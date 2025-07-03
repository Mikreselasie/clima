import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '12d35787f3ea5dfd1cabfa2289457b11';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;
  bool locationError = false;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    print('Starting getLocationData');
    Location location = Location();

    print('Calling getCurrentLocation...');
    await location.getCurrentLocation();
    print('Returned from getCurrentLocation');
    print(
      'Location values: latitude=${location.latitude}, longitude=${location.longitude}',
    );

    if (location.latitude == null || location.longitude == null) {
      print('Failed to get location. Check permissions and device settings.');
      setState(() {
        locationError = true;
      });
      return;
    }

    latitude = location.latitude;
    longitude = location.longitude;
    print('Set latitude and longitude: $latitude, $longitude');

    Networking networking = Networking(
      'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric',
    );
    print("Fetching Weather data");
    var weatherData;
    try {
      print('Calling networking.getData()...');
      weatherData = await networking.getData().timeout(Duration(seconds: 10));
      print('Weather data received: $weatherData');
    } catch (e) {
      print(
        'Error fetching weather data: Timeout or failure: '
        '\u001b[31m$e\u001b[0m',
      );
      setState(() {
        locationError = true;
      });
      return;
    }

    print("About to push the LocationScreen");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('Navigating to LocationScreen...');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LocationScreen(locationWeather: weatherData);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SpinKitCubeGrid(color: Colors.white, size: 100.0),
              Center(
                child: Text(
                  "Loading the Weather",
                  style: kMessageTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
