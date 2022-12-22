import 'package:http/http.dart' as http;
import 'dart:convert';

import 'weather.dart';

class HttpHelper {
  // https://api.openweathermap.org/data/2.5/
  // weather?q=jerusalem&appid=d6aeb1eb950ce7636ec3dfaeac455dab
  final String authority = 'api.openweathermap.org';
  final String path = 'data/2.5/weather';
  final String apikey = 'd6aeb1eb950ce7636ec3dfaeac455dab';

  Future<Weather> getWeather(String location) async {
    Map<String, dynamic> parameters = {'q': location, 'appId': apikey};
    Uri uri = Uri.https(authority, path, parameters);
    http.Response result = await http.get(uri);
    Map<String, dynamic> data= json.decode(result.body);
    Weather weather= Weather.fromJson(data);


    return weather;
  }
}
