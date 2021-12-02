import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = "AIzaSyDY4vY0jzTHicX4zBYH4H1CGTmCZuwr-xs";

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitute}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?'
        'center=$latitude,$longitute&zoom=13&size=600x300&maptype=roadmap'
        '&markers=color:red%7Clabel:C%7C$latitude,$longitute&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY');
    final response = await http.get(url);
    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}
