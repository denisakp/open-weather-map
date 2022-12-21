import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_open_weather_map/notifiers/open_weather_map.dart';
import 'package:flutter_open_weather_map/widgets/widgets.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<OpenWeatherMapNotifier>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Open Weather Map'),
        ),
        backgroundColor: Colors.white,
        body: notifier.isLoading == false ? const View() :const Center(
          child: SpinKitFadingCircle(
              color: Colors.blue, size: 80
          ),
        )
    );
  }
}
