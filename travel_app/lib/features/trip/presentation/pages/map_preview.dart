// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/core/apis/apis.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class MapPreview extends ConsumerStatefulWidget {
  static route(double lat, double lng) {
    return MaterialPageRoute(builder: (context) {
      return MapPreview(
        lat: lat,
        lng: lng,
      );
    });
  }

  const MapPreview({
    super.key,
    required this.lat,
    required this.lng,
  });

  final double lat;
  final double lng;

  @override
  ConsumerState<MapPreview> createState() => _MapPreviewState();
}

class _MapPreviewState extends ConsumerState<MapPreview> {
  late LatLng selectedLatLng;

  bool isCopying = false;

  late Widget copyContent;

  String address = '';

  @override
  void initState() {
    selectedLatLng = LatLng(
      widget.lat,
      widget.lng,
    );
    super.initState();
  }

  void _copyAdress() async {
    ScaffoldMessenger.of(context).clearSnackBars();

    setState(() {
      isCopying = true;
    });

    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${selectedLatLng.latitude},${selectedLatLng.longitude}&key=${Apis.mapApi}');

    final response = await http.get(url);
    if (response.statusCode >= 400) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error occurred! Please try again later.'),
      ));
      setState(() {
        isCopying = false;
      });
    }

    final resData = json.decode(response.body);

    if (resData['results'].isNotEmpty) {
      address = resData['results'][0]['formatted_address'];
      Clipboard.setData(
        ClipboardData(text: address),
      );
      ScaffoldMessenger.of(context).clearSnackBars();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$address copied.'),
      ));
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('No address found for this location.'),
      ));
    }

    setState(() {
      isCopying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    copyContent = IconButton(
      onPressed: _copyAdress,
      icon: Icon(Icons.copy, size: 35),
    );

    if (isCopying) {
      copyContent = SizedBox(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          GoogleMap(
            onTap: (position) {
              setState(() {
                selectedLatLng = position;
              });
            },
            zoomGesturesEnabled: true,
            buildingsEnabled: true,
            mapToolbarEnabled: true,
            initialCameraPosition: CameraPosition(
              target: selectedLatLng,
              zoom: 10,
            ),
            markers: selectedLatLng == LatLng(widget.lat, widget.lng)
                ? {
                    Marker(
                      markerId: MarkerId('selectedPlace'),
                      position: selectedLatLng,
                    ),
                  }
                : {
                    Marker(
                      markerId: MarkerId('initialPlace'),
                      position: LatLng(widget.lat, widget.lng),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueAzure),
                      onTap: () {
                        setState(() {
                          selectedLatLng = LatLng(widget.lat, widget.lng);
                        });
                      },
                    ),
                    Marker(
                      markerId: MarkerId('selectedPlace'),
                      position: selectedLatLng,
                    ),
                  },
          ),
          Positioned(
            right: 0,
            child: Container(
              margin: EdgeInsets.all(10),
              child: copyContent,
            ),
          ),
        ],
      ),
    );
  }
}
