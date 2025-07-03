import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    try {
      print('Checking location permission...');
      LocationPermission permission = await Geolocator.checkPermission();
      print('Permission status: $permission');
      if (permission == LocationPermission.denied) {
        print('Permission denied, requesting permission...');
        permission = await Geolocator.requestPermission();
        print('Permission after request: $permission');
      }

      if (permission == LocationPermission.deniedForever) {
        print(
          'Location permissions are permanently denied, we cannot request permissions.',
        );
        return;
      }

      print('Requesting current position...');
      Position? position;
      try {
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium,
        ).timeout(const Duration(seconds: 10));
        print('Position received: $position');
      } catch (e) {
        print('Error or timeout getting current position: $e');
        print('Trying last known position...');
        position = await Geolocator.getLastKnownPosition();
        if (position != null) {
          print('Last known position received: $position');
        } else {
          print('No last known position available.');
          return;
        }
      }

      latitude = position.latitude;
      longitude = position.longitude;
      print('Current location: $latitude, $longitude');
    } catch (e) {
      print('Error getting location: $e');
    }
  }
}
