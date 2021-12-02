import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation placeLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        placeLocation.latitude, placeLocation.longitude);
    final updatedLocation = PlaceLocation(
        latitude: placeLocation.latitude,
        longitude: placeLocation.longitude,
        address: address);

    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: updatedLocation,
        image: image);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final list = await DBHelper.getData('user_places');
    _items = list
        .map((e) => Place(
            id: e['id'],
            title: e['title'],
            image: File(e['image']),
            location: PlaceLocation(
                latitude: e['loc_lat'],
                longitude: e['loc_lng'],
                address: e['address'])))
        .toList();
  }
}
