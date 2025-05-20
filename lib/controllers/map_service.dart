import 'package:url_launcher/url_launcher.dart';
import 'package:newwave_mobile_test/models/location.dart';

class MapService {
  Future<bool> openInGoogleMaps(Location location) async {
    final double lat = double.tryParse(location.lat ?? "") ?? 0.0;
    final double lon = double.tryParse(location.lon ?? "") ?? 0.0;
    print(location.place_id);
    print(location.display_name);

    // Create Google Maps URL with the location coordinates
    final Uri googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lon&destination_place_id=${location.place_id ?? ''}&travelmode=driving',
    );

    // Check if the URL can be launched
    if (await canLaunchUrl(googleMapsUrl)) {
      return await launchUrl(
        googleMapsUrl,
        mode: LaunchMode.externalApplication,
      );
    } else {
      // Fallback URL without place_id
      final Uri fallbackUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$lat,$lon',
      );

      if (await canLaunchUrl(fallbackUrl)) {
        return await launchUrl(
          fallbackUrl,
          mode: LaunchMode.externalApplication,
        );
      } else {
        print('Could not launch Google Maps');
        return false;
      }
    }
  }
}
