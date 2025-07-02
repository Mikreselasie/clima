import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
