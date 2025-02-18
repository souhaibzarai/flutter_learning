import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/features/trip/domain/enitities/trip.dart';
import 'package:travel_app/features/trip/presentation/providers/trip_provider.dart';
import 'package:travel_app/features/trip/presentation/widgets/trip_card.dart';

class MyTripsScreen extends ConsumerStatefulWidget {
  const MyTripsScreen({super.key});

  @override
  ConsumerState<MyTripsScreen> createState() {
    return _MyTripScreenState();
  }
}

class _MyTripScreenState extends ConsumerState<MyTripsScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(tripListNotifierProvider.notifier).loadTrips();
  }

  @override
  Widget build(BuildContext context) {
    final readNotifier = ref.read(tripListNotifierProvider.notifier);
    final watchNotifier = ref.watch(tripListNotifierProvider.notifier);

    Widget content = Center(
      child: Text('Empty.'),
    );

    final List<Trip> tripList = ref.watch(tripListNotifierProvider);
    if (tripList.isNotEmpty) {
      content = ListView.builder(
        itemCount: tripList.length,
        itemBuilder: (context, index) {
          final trip = tripList[index];
          return Dismissible(
            key: ValueKey(trip),
            background: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error.withOpacity(.52),
              ),
            ),
            child: TripCard(
              trip: trip,
            ),
            onDismissed: (r) {
              readNotifier.removeTrip(index);
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Trip ${trip.title.trim() == '' ? trip.location : trip.title}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        readNotifier.addNewTrip(trip);
                        watchNotifier.loadTrips();
                      }),
                ),
              );
              watchNotifier.loadTrips();
            },
          );
        },
      );
    }
    return content;
  }
}
