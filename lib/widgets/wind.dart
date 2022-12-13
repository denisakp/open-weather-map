import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_open_weather_map/notifiers/notifiers.dart';
import 'owm_widgets.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<OpenWeatherMapNotifier>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: notifier.isLoading == false
        ?
          _View()
          :
            const Center(
              child: SpinKitFadingCircle(color: Colors.blue, size: 80),
            )
    );
  }
}

class Wind extends StatelessWidget {
  const Wind({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<OpenWeatherMapNotifier>();
    final snapshot = notifier.current;
    var speed = snapshot?.windSpeed;

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 10),
              child: ownText(
                  size: 20.0,
                  text: 'Wind',
                  color: primaryColor.withOpacity(.8),
                  isBold: FontWeight.bold
              ),
            ),
            Card(
              color: bgGreyColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   owmListTile(
                       first: 'Speed',
                       second: ' $speed km/h',
                       icon: Icons.air,
                       iconColor: Colors.blue,
                       text: 'direction'
                   )
                  ]
                )
              )
            )
          ]
      )
    );
  }
}

class Carousel extends StatelessWidget {
  const Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<OpenWeatherMapNotifier>();
    final snapshot = notifier.forecast;
    return SizedBox(
      height: 100,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: snapshot?.count,
          itemBuilder: (BuildContext ctx, int index) {
            return ownForecast(index, snapshot?.items);
          }
      ),
    );
  }
}

class Barometer extends StatelessWidget {
  const Barometer({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<OpenWeatherMapNotifier>();
    final snapshot = notifier.current;
    var temp = snapshot?.temp;
    var humidity = snapshot?.humidity;
    var pressure = snapshot?.pressure;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ownText(
                size: 20,
              color: primaryColor.withOpacity(.8),
              text: 'Barometer',
              isBold: FontWeight.bold
            ),
          ),
          Card(
            color: bgGreyColor,
            elevation: 0,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  owmListTile(
                    first: 'Temperature:',
                    second: ' $temp °C',
                    icon: Icons.thermostat,
                    iconColor: Colors.orange,
                  ),
                  owmListTile(
                    first: 'Humidity:',
                    second: ' $humidity %',
                    icon: Icons.water_drop_outlined,
                    iconColor: Colors.blueGrey,
                  ),
                  owmListTile(
                    first: 'Pressure:',
                    second: ' $pressure hPa',
                    icon: Icons.speed,
                    iconColor: Colors.red[300]!,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<OpenWeatherMapNotifier>();

    return Row(
      children: [
        Expanded(
            child: TextField(
              onChanged: ((value) => notifier.city = value),
              onSubmitted: (_) => notifier.onSubmitSearch(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black12,
                hintText: 'Search',
                hintStyle: const TextStyle(color: Colors.black),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.black),
                  onPressed: notifier.onSubmitSearch,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            )
        ),
        const SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black12,
          ),
          child: IconButton(
            padding: const EdgeInsets.all(12),
            iconSize: 26,
            onPressed: notifier.onSubmitLocate,
            icon: const Icon(Icons.location_on_outlined, color: Colors.black),
          ),
        )
      ],
    );
  }
}

class City extends StatelessWidget {
  const City({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<OpenWeatherMapNotifier>();
    final snapshot = notifier.current;
    var city = snapshot?.city;
    var temp = snapshot?.temp;
    var feels = snapshot?.feelsLike;
    var winDeg = snapshot?.windDeg;
    var url = 'http://openweathermap.org/img/wn/${snapshot?.weather.icon}@2x.png';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(url, scale: 1.2),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ownText(
              size: 30,
              text: '$city',
              isBold: FontWeight.bold,
              color: primaryColor,
            ),
            RotationTransition(
              turns: AlwaysStoppedAnimation(winDeg! / 360),
              child: const Icon(Icons.north, color: primaryColor),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ownText(
              size: 50,
              text: '$temp°',
            ),
            ownText(size: 18, text: '$feels°', color: darkGreyColor),
          ],
        )
      ],
    );
  }
}

class _View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = context.read<OpenWeatherMapNotifier>();

    return SafeArea(
        child: Stack(
          children: [
            notifier.current?.city != null
                ?
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          SizedBox(height: 70),
                          City(),
                          SizedBox(height: 15),
                          Carousel(),
                          SizedBox(height: 15),
                          Wind(),
                          SizedBox(height: 15),
                          Barometer(),
                        ]
                    ),
                  )
                :
                  Center(
                    child: ownText(size: 16, text: 'Hello world'),
                  ),
            const Header()
          ],
        )
    );
  }
}
