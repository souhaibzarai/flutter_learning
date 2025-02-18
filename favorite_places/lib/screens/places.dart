import 'package:flutter/material.dart';

import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/widgets/places_list.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/providers/user_places.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() {
    return _PlacesScreenState();
  }
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future _loadedPlaces;

  @override
  void initState() {
    super.initState();
    _loadedPlaces = ref.read(placesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(context) {
    final userPlaces = ref.watch(placesProvider);

    void addPlace() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return const AddPlaceScreen();
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: addPlace,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _loadedPlaces,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : PlacesList(places: userPlaces),
      ),
    );
  }
}
