import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:travel_app/features/trip/presentation/pages/map_preview.dart';

class MapIntrocude extends StatefulWidget {
  const MapIntrocude({super.key});

  @override
  State<MapIntrocude> createState() => _MapIntrocudeState();
}

class _MapIntrocudeState extends State<MapIntrocude> {
  bool isLoading = false;

  Location location = Location();
  late double lat;
  late double lng;

  void onPreviewMap() async {
    setState(() {
      isLoading = true;
    });

    bool serviceEnabled;
    PermissionStatus permissionStatus;
    LocationData currentLocation;

    serviceEnabled = await location.serviceEnabled();
    if (serviceEnabled != true) {
      serviceEnabled = await location.requestService();
      if (serviceEnabled == false) {
        return;
      }
    }
    permissionStatus = await location.requestPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
    }
    currentLocation = await location.getLocation();

    setState(() {
      lat = currentLocation.latitude!;
      lng = currentLocation.longitude!;
    });
    if (!context.mounted) {
      return;
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).push(
      MapPreview.route(lat, lng),
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
          ),
          clipBehavior: Clip.hardEdge,
          child: const GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(50, 0),
            ),
            zoomControlsEnabled: false,
          ),
        ),
        SizedBox(height: 15),
        TextButton.icon(
          onPressed: onPreviewMap,
          icon: Icon(
            Icons.map,
            color: Color.fromARGB(255, 46, 80, 119),
          ),
          label: Text(
            'Preview Map',
            style: TextStyle(
              color: Color.fromARGB(255, 46, 80, 119),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );

    if (isLoading) {
      content = Center(
        child: CircularProgressIndicator(),
      );
    }

    return content;
  }
}
