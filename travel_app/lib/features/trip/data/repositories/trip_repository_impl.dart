import 'package:dartz/dartz.dart';
import 'package:travel_app/core/error/failures.dart';

import '../../domain/enitities/trip.dart';
import '../../domain/repositories/trip_repository.dart';
import '../datasources/trip_local_datasource.dart';
import '../models/trip_model.dart';

class TripRepositoryImpl implements TripRepository {
  final TripLocalDataSource localDataSource;

  TripRepositoryImpl(this.localDataSource);

  @override
  Future<void> addTrip(Trip trip) async {
    final tripModel = TripModel.fromEntity(trip);
    localDataSource.addTrip(tripModel);
  }

  @override
  Future<void> deleteTrip(int index) async {
    localDataSource.deleteTrip(index);
  }

  @override
  Future<Either<Failure, List<Trip>>> getTrips() async {
    try {
      final tripModels = localDataSource.getTrips();
      List<Trip> trips = tripModels.map((model) => model.toEntity()).toList();

      return right(trips);
    } catch (err) {
      return left(
        SomeSpecificError('$err'),
      );
    }
  }
}
