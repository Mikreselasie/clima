import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({required this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double temperature = 20;
  String cityName = 'Asela';
  int condition = 330;
  String description = "Day";
  int humidity = 63;
  int pressure = 1011;

  @override
  void initState() {
    super.initState();

    print(widget.locationWeather);
    temperature = widget.locationWeather['main']['temp'];
    cityName = widget.locationWeather['name'];
    condition = widget.locationWeather['weather'][0]['id'];
    description = widget.locationWeather['weather'][0]['main'];
    humidity = widget.locationWeather['main']['humidity'];
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      minimumSize: Size(64, 64),
      padding: EdgeInsets.zero,
      backgroundColor: Colors.blue,
      elevation: 4,
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    // Refresh button
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          // Refresh action
                        },
                        style: buttonStyle,
                        child: Center(
                          child: Icon(
                            Icons.refresh,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    // City label
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: Text("$cityName", style: kCityTextStye),
                      ),
                    ),

                    // Search button (same style)
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          // Search action
                        },
                        style: buttonStyle,
                        child: Center(
                          child: Icon(
                            Icons.search,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Transform.scale(
              scale: 1.5,
              child: Image.asset('images/sunny.png', width: 200, height: 200),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('$temperature°', style: kMessageTextStyle),
                SizedBox(width: 5),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(description, style: ksubTexts),
                    Text('H: $humidity° | L: $pressure', style: ksubTexts),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
