import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyB51Jzamw0fMoCZamdU78Hl-uANvt4VF50';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return '''https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=14&size=600x300&maptype=roadmap
&markers=color:red%7Clabel:A%7C$latitude,$longitude
&key=$GOOGLE_API_KEY''';
  }

  static Future<String> getAddress(double lat, double lng) async {
    final params = {'latlng': '$lat,$lng', 'key': GOOGLE_API_KEY};

    var url =
        Uri.https('maps.googleapis.com', '/maps/api/geocode/json', params);

    var response = await http.get(url);
    print(response.statusCode);

    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}
