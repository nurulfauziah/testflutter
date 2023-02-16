import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:testflutter/helper/navigation.dart';

class LocationHelper {
  // final WeatherBloc _weatherBloc = WeatherBloc();

  // CurrentWeatherModel? currentWeather;
  // WeekWeatherModel? weekWeather;
  String? _currentAddress = '';
  Position? _currentPosition;
  double? lat;
  double? long;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(ctx).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    return true;
  }

  Future<Position?> getCurrentPosition() async {
    try {
      await _handleLocationPermission();
      // if (!hasPermission) return;
      Position positionTets = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("Current Position: ${positionTets.latitude}");
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        _currentPosition = position;
        log("${position.latitude}lat");
        // _getAddressFromLatLng(position);

        return position;
      }).catchError((e) {
        return null;
        // debugPrint(e);
      });
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<String?> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      // setState(() {
      _currentAddress =
          "${place.street?.toString()}, ${place.subAdministrativeArea}";
      log('${place.street}'.toString());
      // });
      return _currentAddress;
    }).catchError((e) {
      debugPrint(e);
    });
    return null;
  }
}
