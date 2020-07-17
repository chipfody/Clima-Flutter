import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      // the higher the accuracy of the geolocation, the more battery intensive the app will be

      latitude = position.latitude;
      longitude = position.longitude;

    } catch (exception) {
      print(exception);
    }
  }
}
