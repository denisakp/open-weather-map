import 'constants.dart';

class OpenWeatherMapAPI {
  // open weather string
  static const String _baseURL = "api.openweathermap.org";
  static const String _path = "/data/2.5/";
  static const String apiKey = APIConstant.apiKey;

  // fetch current weather using geolocation
  Uri geocodingWeather(var lat, var long) => _buildURI(
      endpoint: 'weather',
      parameterBuilder: () => _geoQueryParameter(lat, long),
  );

  // weather uri builder
  Uri weather(String city) => _buildURI(
    endpoint: 'weather',
    parameterBuilder: () =>  _defaultQueryParameters(city),
  );

  // forecast uri builder
  Uri forecast(String city) => _buildURI(
    endpoint: 'forecast',
    parameterBuilder: () => _defaultQueryParameters(city),
  );

  // uri builder
  Uri _buildURI({ required String endpoint, required Map<String, dynamic> Function() parameterBuilder}) {
    return Uri(
        scheme: 'https',
        host: _baseURL,
        path: '$_path$endpoint',
        queryParameters: parameterBuilder()
    );
  }

  // city query parameter
  Map<String, dynamic> _defaultQueryParameters(String city) => {
    'appid': apiKey,
    'units': 'metric',
    'q': city,
  };

  // geolocation query parameter
  Map<String, dynamic> _geoQueryParameter(var lat, var lon) => {
    'appid': apiKey,
    'units': 'metric',
    'lat': lat.toString(),
    'lon': lon.toString()
  };
}
