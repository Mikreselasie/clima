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

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    // try {
    //   await location.getCurrentLocation().timeout(Duration(seconds: 10));
    // } catch (e) {
    //   print(
    //     'Error fetching location: Timeout or failure: '
    //     '\u001b[31m$e\u001b[0m',
    //   );
    //   // Optionally, show an error dialog or message here
    //   return;
    // }

    latitude = 7.56;
    longitude = 37.8;

    Networking networking = Networking(
      'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric',
    );
    print("Fetching Weather data");
    var weatherData;
    try {
      weatherData = await networking.getData().timeout(Duration(seconds: 10));
    } catch (e) {
      print(
        'Error fetching weather data: Timeout or failure: '
        '\u001b[31m$e\u001b[0m',
      );
      // Optionally, show an error dialog or message here
      return;
    }

    // Defer navigation until after the first frame
    print("About to push the LocationScreen");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LocationScreen(locationWeather: weatherData);
          },
        ),
      );
    });

    // You can still process weatherData here if needed
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
