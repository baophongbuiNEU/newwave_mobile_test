// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Location _$LocationFromJson(Map<String, dynamic> json) => _Location(
  display_name: json['display_name'] as String?,
  lat: json['lat'] as String?,
  lon: json['lon'] as String?,
  place_id: json['place_id'] as String?,
);

Map<String, dynamic> _$LocationToJson(_Location instance) => <String, dynamic>{
  'display_name': instance.display_name,
  'lat': instance.lat,
  'lon': instance.lon,
  'place_id': instance.place_id,
};
