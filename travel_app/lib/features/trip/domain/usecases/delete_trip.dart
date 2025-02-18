import 'package:travel_app/features/trip/domain/repositories/trip_repository.dart';

class DeleteTrip {
  final TripRepository repository;

  DeleteTrip(this.repository);

  call(int index) => repository.deleteTrip(index);
}
