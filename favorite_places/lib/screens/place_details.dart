import 'package:favorite_places/constants/constants.dart';
import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/map.dart';
import 'package:flutter/material.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({
    super.key,
    required this.place,
  });

  final Place place;

  String get locationImage {
    final lat = place.location.latitude;
    final lng = place.location.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?zoom=15&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$lat,$lng&key=$api';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) {
                        return MapScreen(
                          isSelecting: false,
                          location: place.location,
                        );
                      }),
                    );
                  },
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(locationImage),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  child: Text(
                    place.location.address,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
