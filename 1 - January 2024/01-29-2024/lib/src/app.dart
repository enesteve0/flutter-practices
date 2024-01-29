import 'package:flutter/material.dart';
import 'resources/weather_api_client.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final WeatherApiClient _apiClient = WeatherApiClient();
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  Map<String, dynamic>? _weatherData;
  String? _errorMessage;

  Future<void> _fetchWeather() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
        _errorMessage = null;
      });
      try {
        _weatherData = await _apiClient.fetchWeather(_controller.text);
      } catch (e) {
        _errorMessage = 'City not found';
        _weatherData = null;
      }
      setState(() {
        _loading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Enter a city',
                    errorText: _errorMessage,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a city';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _loading ? null : _fetchWeather,
                child: const Text('Get Weather'),
              ),
              if (_loading)
                const CircularProgressIndicator()
              else if (_weatherData != null)
                Column(
                  children: [
                    Text(
                      '🌡️ Temperature: ${(_weatherData!['main']['temp'] - 273.15).round()}°C',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '☁️ Weather Condition: ${_weatherData!['weather'][0]['description']}',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '💧 Humidity: ${_weatherData!['main']['humidity']}%',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '💨 Wind Speed: ${_weatherData!['wind']['speed']} m/s',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '🌅 Sunrise: ${DateTime.fromMillisecondsSinceEpoch(_weatherData!['sys']['sunrise'] * 1000).toLocal().hour.toString().padLeft(2, '0')}:${DateTime.fromMillisecondsSinceEpoch(_weatherData!['sys']['sunrise'] * 1000).toLocal().minute.toString().padLeft(2, '0')}',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '🌇 Sunset: ${DateTime.fromMillisecondsSinceEpoch(_weatherData!['sys']['sunset'] * 1000).toLocal().hour.toString().padLeft(2, '0')}:${DateTime.fromMillisecondsSinceEpoch(_weatherData!['sys']['sunset'] * 1000).toLocal().minute.toString().padLeft(2, '0')}',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '🌍 Country: ${_weatherData!['sys']['country']}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}