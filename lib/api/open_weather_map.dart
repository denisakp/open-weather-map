import 'constants.dart';

class OpenWeatherMapAPI {
  // open weather string
  static const String _baseURL = "api.openweathermap.org";
  static const String _path = "/data/2.5/";
  static const String apiKey = APIConstant.apiKey;

  // weather uri builder
  Uri weather(String city) => _buildURI(
    endpoint: 'weather',
    parameterBuilder: () =>  defaultQueryParameters(city),
  );

  // forecast uri builder
  Uri forecast(String city) => _buildURI(
    endpoint: 'forecast',
    parameterBuilder: () => defaultQueryParameters(city),
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

  // default query parameter
  Map<String, dynamic> defaultQueryParameters(String city) => {
    'appid': apiKey,
    'units': 'metric',
    'q': city,
  };

  // city name query parameter
  Map<String, dynamic> latLonQueryParameter(double lat, double lon) => {
    'appid': apiKey,
    'units': 'metric',
    'lat': lat,
    'long': lon
  };
}
