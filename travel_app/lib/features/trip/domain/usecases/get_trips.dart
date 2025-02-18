import 'package:dartz/dartz.dart';
import 'package:travel_app/core/error/failures.dart';
import 'package:travel_app/features/trip/domain/enitities/trip.dart';
import 'package:travel_app/features/trip/domain/repositories/trip_repository.dart';

class GetTrips {
  final TripRepository repository;

  GetTrips(this.repository);

  Future<Either<Failure, List<Trip>>> call() {
    return repository.getTrips();
  }
}
