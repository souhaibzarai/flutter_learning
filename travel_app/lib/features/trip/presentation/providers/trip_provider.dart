import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:travel_app/features/trip/data/datasources/trip_local_datasource.dart';
import 'package:travel_app/features/trip/data/models/trip_model.dart';
import 'package:travel_app/features/trip/data/repositories/trip_repository_impl.dart';
import 'package:travel_app/features/trip/domain/enitities/trip.dart';
import 'package:travel_app/features/trip/domain/repositories/trip_repository.dart';
import '../../domain/usecases/delete_trip.dart';
import '../../domain/usecases/get_trips.dart';

import '../../domain/usecases/add_trip.dart';

final tripLocalDataSourceProvider = Provider<TripLocalDataSource>((ref) {
  final Box<TripModel> tripBox = Hive.box('trips');
  return TripLocalDataSource(tripBox);
});

final tripRepositoryProvider = Provider<TripRepository>((ref) {
  final localDataSource = ref.read(tripLocalDataSourceProvider);
  return TripRepositoryImpl(localDataSource);
});

final addTripProvider = Provider<AddTrip>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return AddTrip(repository);
});

final deleteTripProvider = Provider<DeleteTrip>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return DeleteTrip(repository);
});

final getTripsProvider = Provider<GetTrips>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return GetTrips(repository);
});

final tripListNotifierProvider =
    StateNotifierProvider<TripListNotifier, List<Trip>>((ref) {
  final getTrips = ref.read(getTripsProvider);
  final addTrip = ref.read(addTripProvider);
  final deleteTrip = ref.read(deleteTripProvider);

  return TripListNotifier(getTrips, addTrip, deleteTrip);
});

class TripListNotifier extends StateNotifier<List<Trip>> {
  final DeleteTrip _deleteTrip;
  final AddTrip _addTrip;
  final GetTrips _getTrips;

  TripListNotifier(this._getTrips, this._addTrip, this._deleteTrip) : super([]);

  Future<void> addNewTrip(Trip trip) async {
    await _addTrip(trip);
  }

  Future<void> removeTrip(int tripId) async {
    await _deleteTrip(tripId);
  }

  Future<void> loadTrips() async {
    final tripsOrFailure = await _getTrips();
    tripsOrFailure.fold((error) => state = [], (trips) => state = trips);
  }
}
