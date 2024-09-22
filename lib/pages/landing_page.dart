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
    return PopScope(
      canPop: Get.currentRoute != '/', // Prevent back navigation if at the root
      onPopInvoked: (didPop) {
        if (didPop) {
          // Allow back navigation
          print("Back button pressed and route was popped.");
        } else {
          // Prevent pop, redirect to LandingPage if on main screen
          Get.offAll(() => const LandingPage());
          print("Back button press blocked, redirected to LandingPage.");
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFEDE7F6), // Light purple background
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Enter City",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF6A1B9A), // Darker purple text
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: textEditingController,
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      fetchWeather(value.trim());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please enter a city name")),
                      );
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:
                        Colors.white, // White background for the text field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Color(0xFF6A1B9A)), // Purple border
                    ),
                    hintText: 'City name',
                    hintStyle: const TextStyle(
                        color: Color(0xFF9A7BCA)), // Light purple hint
                  ),
                ),
                const SizedBox(height: 20),
                _isLoading // Show loading indicator while fetching data
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, // White text
                          backgroundColor:
                              const Color(0xFF6A1B9A), // Purple button color
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
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
                        child: const Text(
                          "Search Weather",
                          style: TextStyle(color: Colors.white), // White text
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
