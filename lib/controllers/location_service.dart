import 'package:dio/dio.dart';
import 'package:newwave_mobile_test/common/config.dart';
import 'package:newwave_mobile_test/models/location.dart';

class LocationService {
  final Dio _dio = Dio();

  Future<List<Location>> searchLocations(String query) async {
    if (query.length < 2) {
      return [];
    }

    try {
      var response = await _dio.get(
        'https://api.locationiq.com/v1/autocomplete?key=$API_KEY&q=$query&limit=5&dedupe=1&',
      );

      if (response.data is List) {
        return (response.data as List)
            .map((json) => Location.fromJson(json))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching locations: $e');
      return [];
    }
  }
}
