import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/pages/landing_page.dart';
import 'package:myapp/widgets/widgets.dart'; // Assuming widgets like locationHeader, dateTimeInfo, etc. are already created.
import 'package:weather/weather.dart';

class HomePage extends StatefulWidget {
  final Weather weather; // Expecting weather data to be passed from LandingPage

  const HomePage({super.key, required this.weather});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _weather =
        widget.weather; // Assign the passed weather to the state variable
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF6A1B9A), // Purple app bar
            title: const Text(
              "Weather App",
              style: TextStyle(color: Colors.white), // White text
            ),
            centerTitle: true,
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // White text
                  backgroundColor:
                      const Color(0xFF6A1B9A), // Purple button color
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                ),
                onPressed: () {
                  Get.to(const LandingPage());
                },
                child: const Icon(Icons.search, color: Colors.white),
              ),
            ],
          ),
          body: SafeArea(
            child: Container(
              color: const Color(0xFFEDE7F6), // Light purple background
              child: _buildUI(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUI() {
    // Show a loading indicator if the weather data is still being processed
    if (_weather == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Displaying location information from weather
            locationHeader(
                _weather!), // Assuming locationHeader takes Weather as a parameter
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),

            // Displaying DateTime info
            dateTimeInfo(
                _weather!), // Assuming dateTimeInfo takes Weather as a parameter
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),

            // Displaying weather icon
            weatherIcon(context,
                _weather!), // Assuming weatherIcon takes Weather and BuildContext as parameters
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            // Displaying current temperature
            currentTemp(
                _weather!), // Assuming currentTemp takes Weather as a parameter
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            // Displaying extra information (humidity, wind, etc.)
            extraInfo(context, _weather!),
            const SizedBox(
              height: 10,
            ) // Assuming extraInfo takes Weather and BuildContext as parameters
          ],
        ),
      ),
    );
  }
}
