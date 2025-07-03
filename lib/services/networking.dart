import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
  Networking(this.url);

  final String url;

  Future getData() async {
    print('Requesting weather from: $url');
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);

      return decodedData;
    } else {
      print(
        'Failed to fetch weather data: \u001b[33m${response.statusCode}\u001b[0m',
      );
    }
  }
}
