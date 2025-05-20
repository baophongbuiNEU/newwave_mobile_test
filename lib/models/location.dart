import 'package:freezed_annotation/freezed_annotation.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@freezed
sealed class Location with _$Location {
  factory Location({
    String? display_name,
    String? lat,
    String? lon,
    String? place_id,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
