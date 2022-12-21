import 'weather.dart';

// need this for later maybe when i'll build the screen for forecast item detail
class Location {
  final String city;
  final DateTime sunrise;
  final DateTime sunset;
  final double longitude;
  final double latitude;

  Location({
    required this.city,
    required this.sunset,
    required this.sunrise,
    required this.longitude,
    required this.latitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        city: json['name'],
        sunset: DateTime.fromMillisecondsSinceEpoch(json['sunset'] * 1000),
        sunrise: DateTime.fromMillisecondsSinceEpoch(json['sunrise'] * 1000),
        longitude: json['coord']['lon'] as double,
        latitude: json['coord']['lat'] as double,
    );
  }
}

// those commented properties may be used when i'll build the forecast detail screen
class Item {
    Item({
      //required this.dt,
      required this.weather,
      required this.temp,
      // required this.tempMin,
      // required this.tempMax,
      // required this.humidity,
      // required this.pressure,
      // required this.feelsLike,
      required this.dtTxt,
    });

    // final DateTime dt;

    final int temp;
    // final double feelsLike;
    // final double tempMin;
    // final double tempMax;
    // final int pressure;
    // final int humidity;

    final Weather weather;

    final DateTime dtTxt; // forecast datetime 2022-12-14 03:00:00 (step = every 3 hours )

    factory Item.fromJson(Map<String, dynamic> json) {
      return Item(
          // dt: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
          weather: Weather.fromJson(json['weather'][0]),
          temp: json['main']['temp'].ceil(),
          // tempMin: json['main']['temp_min'].toDouble(),
          // tempMax: json['main']['temp_max'].toDouble(),
          // humidity: json['main']['humidity'],
          // pressure: json['main']['pressure'],
          // feelsLike: json['main']['feels_like'].toDouble(),
          dtTxt: DateTime.parse(json['dt_txt'])
      );
    }
}

class Forecast {
  Forecast({
    required this.count,
    required this.items
  });

  final int count;
  final List<Item> items;

  factory Forecast.fromJson(Map<String, dynamic>json) {
    var list = json['list'] as List;
    return Forecast(
        count: json['cnt'] as int,
        items: list.map((item) => Item.fromJson(item)).toList()
    );
  }
}