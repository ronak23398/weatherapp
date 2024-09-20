import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/const.dart';
import 'package:myapp/pages/home_page.dart';
import 'package:weather/weather.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final TextEditingController textEditingController = TextEditingController();
  final WeatherFactory _wf = WeatherFactory(openweather_api_key);
  bool _isLoading = false; // For showing loading state

  Future<void> fetchWeather(String cityName) async {
    setState(() {
      _isLoading = true;
    });

    try {
      Weather weather = await _wf.currentWeatherByCityName(cityName);
      Get.off(() => HomePage(weather: weather));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching weather: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
      textEditingController.clear(); // Clear the input after submission
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Enter City"),
            const SizedBox(height: 10),
            TextField(
              controller: textEditingController,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  fetchWeather(value.trim());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter a city name")),
                  );
                }
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'City name',
              ),
            ),
            const SizedBox(height: 20),
            _isLoading // Show loading indicator while fetching data
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      String cityName = textEditingController.text.trim();
                      if (cityName.isNotEmpty) {
                        fetchWeather(cityName);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please enter a city name")),
                        );
                      }
                    },
                    child: const Text("Search Weather"),
                  ),
          ],
        ),
      ),
    );
  }
}
