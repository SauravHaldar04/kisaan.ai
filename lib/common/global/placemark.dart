
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class PlacemarkProvider extends ChangeNotifier {
  List<Placemark> _placemarks = [];

  List<Placemark> get placemarks => _placemarks;

  set placemarks(List<Placemark> value) {
    _placemarks = value;
    notifyListeners();
  }
}
