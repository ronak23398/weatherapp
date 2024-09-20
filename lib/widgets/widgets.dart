import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

Widget locationHeader(Weather? weather) {
  return Text(
    weather?.areaName ?? "",
    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
  );
}

Widget dateTimeInfo(Weather? weather) {
  DateTime now = weather?.date ?? DateTime.now();
  return Column(
    children: [
      Text(
        DateFormat("hh:mm a").format(now),
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(DateFormat("d MMMM y").format(now),
              style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    ],
  );
}

Widget weatherIcon(BuildContext context, Weather? weather) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.20,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://openweathermap.org/img/wn/${weather?.weatherIcon}@4x.png"),
          ),
        ),
      ),
      Text(weather?.weatherDescription ?? "",
          style: const TextStyle(fontSize: 20, color: Colors.black)),
    ],
  );
}

Widget currentTemp(Weather? weather) {
  return Text(
    "${weather?.temperature?.celsius?.toStringAsFixed(0) ?? 'N/A'}° C",
    style: const TextStyle(
        fontSize: 90, fontWeight: FontWeight.w500, color: Colors.black),
  );
}

Widget extraInfo(BuildContext context, Weather? weather) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.15,
    width: MediaQuery.of(context).size.width * 0.80,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.deepPurpleAccent,
    ),
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Max: ${weather?.tempMax?.celsius?.toStringAsFixed(0) ?? 'N/A'}° C",
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            Text(
              "Min: ${weather?.tempMin?.celsius?.toStringAsFixed(0) ?? 'N/A'}° C",
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Wind: ${weather?.windSpeed?.toStringAsFixed(0) ?? 'N/A'} m/s",
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            Text(
              "Humidity: ${weather?.humidity?.toStringAsFixed(0) ?? 'N/A'}%",
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
      ],
    ),
  );
}
