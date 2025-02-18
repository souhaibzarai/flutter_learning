import 'package:dartz/dartz.dart';
import 'package:travel_app/core/error/failures.dart';
import 'package:travel_app/features/trip/domain/enitities/trip.dart';

abstract class TripRepository {
  Future<void> addTrip(Trip trip);
  Future<void> deleteTrip(int index);
  Future<Either<Failure, List<Trip>>> getTrips();
}
