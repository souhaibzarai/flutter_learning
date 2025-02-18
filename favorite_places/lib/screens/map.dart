import 'package:flutter/material.dart';

import 'package:favorite_places/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 10,
      longitude: 100,
      address: '',
    ),
    this.isSelecting = true,
  });

  final PlaceLocation? location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLatLng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSelecting ? 'Select Location' : 'Your Location',
        ),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _pickedLatLng == null
                  ? null
                  : () {
                      Navigator.of(context).pop(
                        _pickedLatLng,
                      );
                    },
            ),
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isSelecting
            ? null
            : (position) {
                setState(() {
                  _pickedLatLng = position;
                });
              },
        initialCameraPosition: CameraPosition(
          target: _pickedLatLng ??
              LatLng(
                widget.location!.latitude,
                widget.location!.longitude,
              ),
          zoom: _pickedLatLng == null ? 12 : 9,
        ),
        markers: (_pickedLatLng == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: _pickedLatLng ??
                      LatLng(
                        widget.location!.latitude,
                        widget.location!.longitude,
                      ),
                ),
              },
      ),
    );
  }
}
