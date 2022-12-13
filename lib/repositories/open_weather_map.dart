import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;

import 'package:flutter_open_weather_map/api/api.dart';
import 'package:flutter_open_weather_map/exceptions/exceptions.dart';
import 'package:flutter_open_weather_map/models/models.dart';
import 'package:flutter_open_weather_map/services/services.dart';

class OpenWeatherMapRepository {
  OpenWeatherMapAPI api = OpenWeatherMapAPI();
  final ServiceLocation _location = ServiceLocation();
  final Client _client = Client();

  // current weather using geolocation
  Future<Current> geoFetch() async {
    var userLocation = await _location.determinePosition();

    var lat = double.parse((userLocation.latitude).toStringAsFixed(2));
    var long = double.parse((userLocation.longitude).toStringAsFixed(2));

    debugPrint('latitude: $lat, longitude: $long');

    return _sendRequest(
        uri: api.geocodingWeather(lat, long),
        builder: (data) =>  Current.fromJSon(data)
    );
  }

  // current weather repository
  Future<Current> fetchCurrent(String city) => _sendRequest(
    uri: api.weather(city),
    builder: (data) => Current.fromJSon(data)
  );

  // Forecast repository
  Future<Forecast> fetchForecast(String city) => _sendRequest(
      uri: api.forecast(city),
      builder: (data) => Forecast.fromJson(data)
  );

  // htt request
  Future<T> _sendRequest<T>({required Uri uri, required T Function(dynamic data) builder}) async {
    try {
      debugPrint('URI: ${uri.toString()}');
      final response = await _client.get(uri);
      debugPrint(response.body.toString());
      switch(response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return builder(data);
        case 401:
          throw HTTPException(401, 'Invalid API KEY');
        case 404:
          throw HTTPException(404, 'Resource not found');
        default:
          throw HTTPException(500, 'API error');
      }
    } on SocketException catch(_) {
      debugPrint("socket error");
      rethrow;
    }
  }
}