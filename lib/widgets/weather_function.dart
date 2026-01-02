// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

const String apiKey = "8a0279f7d78d9da642eec0c90fd2e1bb";
Future<double?> getTemperatureCelsius() async {
  try {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("Location permission denied");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint("Location permissions are permanently denied");
      return null;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      timeLimit: const Duration(seconds: 10),
    );

    final dio = Dio();
    final url =
        "https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&units=metric&appid=$apiKey";

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final data = response.data;
      return (data['main']['temp'] as num).toDouble();
    } else {
      debugPrint("Failed to fetch weather");
      return null;
    }
  } catch (e) {
    debugPrint("Error fetching temperature: $e");
    return null;
  }
}
