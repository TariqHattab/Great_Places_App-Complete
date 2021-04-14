import 'dart:io';

import 'package:flutter/material.dart';

import 'package:great_places_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File imagePicked) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        image: imagePicked,
        location: null);

    _items.add(newPlace);
    notifyListeners();
  }
}
