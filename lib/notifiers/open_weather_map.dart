import 'package:flutter/cupertino.dart';

import 'package:flutter_open_weather_map/models/models.dart';
import 'package:flutter_open_weather_map/repositories/repositories.dart';

class OpenWeatherMapNotifier extends ChangeNotifier {
  OpenWeatherMapRepository repository = OpenWeatherMapRepository();

  Current? _current;
  Current? get current => _current;

  Forecast? _forecast;
  Forecast? get forecast => _forecast;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String city = '';

  OpenWeatherMapNotifier() {
    setup();
  }

  Future<void> setup() async {
    _current ??= await repository.fetchCurrent('Casablanca');
    _forecast ??= await repository.fetchForecast('Casablanca');
    updateState();
  }

  void onSubmitLocate() async {
    updateState();
    _current = await repository.geoFetch();
    city = _current!.city;
    updateState();
    debugPrint('location submitted');
  }

  void onSubmitSearch() async {
    if(city.isEmpty) return;
    updateState();
    _current = await repository.fetchCurrent(city);
    updateState();
    debugPrint('onSubmitSearch');
  }


  void updateState() {
    _isLoading = !_isLoading;
    notifyListeners();
  }
}