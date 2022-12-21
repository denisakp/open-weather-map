import 'weather.dart';

class Current {
  Current({
    required this.weather,
    required this.temp,
    // required this.tempMin,
    //required this.tempMax,
    required this.humidity,
    required this.dt,
    required this.city,
    // required this.longitude,
    // required this.latitude,
    required this.sunset,
    required this.sunrise,
    required this.windSpeed,
    required this.windDeg,
    required this.pressure,
    required this.feelsLike,
  });

  final Weather weather;

  final int temp;
  // final double tempMin;
  // final double tempMax;
  final int humidity;
  final int pressure;
  final int feelsLike;

  final DateTime dt;

  final String city;
  // final double longitude;
  // final double latitude;

  final DateTime sunset;
  final DateTime sunrise;

  final double windSpeed;
  final int windDeg;
  
  factory Current.fromJSon(Map<String, dynamic> json) {
    return Current(
        weather: Weather.fromJson(json['weather'][0]),
        temp: json['main']['temp'].ceil(),
        // tempMin: json['main']['temp_min'] as double,
        // tempMax: json['main']['temp_max'] as double,
        humidity: json['main']['humidity'] as int,
        dt: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
        city: json['name'],
        // longitude: json['coord']['lon'] as double,
        // latitude: json['coord']['lat'] as double,
        sunset: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000),
        sunrise: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000),
        windDeg: json['wind']['deg'] as int,
        windSpeed: json['wind']['speed'],
        feelsLike: json['main']['feels_like'].ceil(),
        pressure: json['main']['pressure']
    );
  }
}