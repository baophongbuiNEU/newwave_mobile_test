// Providers
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newwave_mobile_test/controllers/location_service.dart';
import 'package:newwave_mobile_test/controllers/map_service.dart';

final locationServiceProvider = Provider((ref) => LocationService());
final mapServiceProvider = Provider((ref) => MapService());