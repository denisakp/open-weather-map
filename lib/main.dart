import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flutter_open_weather_map/widgets/wind.dart';
import 'notifiers/notifiers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open WeatherMap',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ChangeNotifierProvider(
          create: (_) => OpenWeatherMapNotifier(),
          lazy: false,
          child: const MainScreen(),
        ),
      ),
    );
  }
}
