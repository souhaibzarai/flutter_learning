import 'package:travel_app/features/trip/domain/enitities/trip.dart';
import 'package:travel_app/features/trip/domain/repositories/trip_repository.dart';

class AddTrip {
  final TripRepository repository;

  AddTrip(this.repository);

  Future<void> call(Trip trip) => repository.addTrip(trip);
}
