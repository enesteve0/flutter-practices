import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherApiClient {
  final _baseUrl = 'http://api.openweathermap.org/data/2.5';
  final _apiKey = '8be7dadc4655736a7b12dad1c86ebeb0';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final response = await http.get(Uri.parse('$_baseUrl/weather?q=$city&appid=$_apiKey'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load weather data');
    }
  }
}