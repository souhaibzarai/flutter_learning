import 'dart:convert';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/constants/constants.dart';
import 'package:favorite_places/screens/map.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends ConsumerStatefulWidget {
  const LocationInput({
    super.key,
    required this.onPickLocation,
  });

  final void Function(PlaceLocation location) onPickLocation;

  @override
  ConsumerState<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends ConsumerState<LocationInput> {
  bool _isGettingLocation = false;

  PlaceLocation? _pickedLocation;

  String get locationImage {
    if (_pickedLocation == null) {
      return '';
    }
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?zoom=10&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$lat,$lng&key=$api';
  }

  Future<void> _savePlace(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$api');

    final response = await http.get(url);
    if (response.statusCode >= 400) {
      throw Exception('Error Occurred');
    }

    final resData = json.decode(response.body);
    final address = resData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: latitude,
        longitude: longitude,
        address: address,
      );
      _isGettingLocation = false;
    });

    widget.onPickLocation(_pickedLocation!);
  }

  void _getCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionStatus;
    LocationData locationData;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();

    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) {
      return;
    }

    _savePlace(lat, lng);
  }

  void _selectOnMap() async {
    final pickedPosition = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) {
          return const MapScreen();
        },
      ),
    );

    if (pickedPosition == null) {
      return;
    }

    _savePlace(pickedPosition.latitude, pickedPosition.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No Place chosen yet!',
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
    );

    if (_isGettingLocation) {
      previewContent = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_pickedLocation != null) {
      previewContent = Image.network(
        locationImage,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(.2),
            ),
          ),
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          child: previewContent,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              label: const Text('Get Current Location'),
              icon: const Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              label: const Text('Select on Map'),
              icon: const Icon(Icons.map),
            ),
          ],
        ),
      ],
    );
  }
}
