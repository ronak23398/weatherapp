import 'package:flutter/material.dart';
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
    return Scaffold(
      body: SafeArea(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    // Show a loading indicator if the weather data is still being processed
    if (_weather == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Displaying location information from weather
          locationHeader(
              _weather!), // Assuming locationHeader takes Weather as a parameter
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),

          // Displaying DateTime info
          dateTimeInfo(
              _weather!), // Assuming dateTimeInfo takes Weather as a parameter
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),

          // Displaying weather icon
          weatherIcon(context,
              _weather!), // Assuming weatherIcon takes Weather and BuildContext as parameters
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

          // Displaying current temperature
          currentTemp(
              _weather!), // Assuming currentTemp takes Weather as a parameter
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

          // Displaying extra information (humidity, wind, etc.)
          extraInfo(context,
              _weather!), // Assuming extraInfo takes Weather and BuildContext as parameters
        ],
      ),
    );
  }
}
