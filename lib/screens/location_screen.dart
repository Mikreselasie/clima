import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({required this.locationWeather});

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

    temperature = widget.locationWeather['main']['temp'];
    cityName = widget.locationWeather['name'];
    condition = widget.locationWeather['weather'][0]['id'];
    description = widget.locationWeather['weather'][0]['main'];
    humidity = widget.locationWeather['main']['humidity'];
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonSize = screenSize.width * 0.12;

    final buttonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      minimumSize: Size(buttonSize, buttonSize),
      padding: EdgeInsets.zero,
      backgroundColor: kSecondaryColor,
      elevation: 4,
    );

    return Scaffold(
      backgroundColor: kPrimaryDark,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: EdgeInsets.all(screenSize.width * 0.025),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: buttonStyle,
                      child: Icon(
                        Icons.refresh,
                        size: buttonSize * 0.5,
                        color: kSoftGray,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Center(child: Text(cityName, style: kCityTextStye)),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                      },
                      style: buttonStyle,
                      child: Icon(
                        Icons.search,
                        size: buttonSize * 0.5,
                        color: kSoftGray,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Weather icon
            Expanded(
              flex: 5,
              child: Transform.scale(
                scale: 2.5,
                child: Image.asset('images/sunny.png'),
              ),
            ),

            // Temperature & description
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.04,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${temperature.round()}°', style: kMessageTextStyle),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(description, style: ksubTexts),
                      Text('H: $humidity° | L: $pressure', style: ksubTexts),
                      SizedBox(height: 13),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Forecast section
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    buildTodayCard(),
                    SizedBox(width: 10),

                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 10),
                                Text("5 DAYS FORECAST", style: ksubTexts),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                buildForecastCard(),
                                SizedBox(width: 10),
                                buildForecastCard(),
                                SizedBox(width: 10),
                                buildForecastCard(),
                                SizedBox(width: 10),
                                buildForecastCard(),
                                SizedBox(width: 10),
                                buildForecastCard(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTodayCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: 120,
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text("TODAY", style: ksubTexts),
          SizedBox(height: 8),
          Image.asset('images/storm.png', height: 60, width: 60),
          SizedBox(height: 8),
          Text('51° / 59°', style: ksubTexts),
          Text("SHOWER", style: ksubTexts),
        ],
      ),
    );
  }

  Widget buildForecastCard() {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 1, 40, 71),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue, width: 1.5),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Image.asset('images/storm.png', height: 30, width: 30),
          SizedBox(height: 6),
          Text('51° / 59°', style: ksubTexts),
          Text("SHOWER", style: ksubTexts),
        ],
      ),
    );
  }
}
