import 'package:hive/hive.dart';
import 'package:travel_app/features/trip/domain/enitities/trip.dart';

part 'trip_model.g.dart';

@HiveType(typeId: 0)
class TripModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String photo;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String date;
  @HiveField(4)
  final String location;

  TripModel({
    required this.title,
    required this.photo,
    required this.description,
    required this.date,
    required this.location,
  });

  factory TripModel.fromEntity(Trip trip) => TripModel(
        title: trip.title,
        photo: trip.photo,
        description: trip.description,
        date: trip.date,
        location: trip.location,
      );

  Trip toEntity() => Trip(
        title: title,
        photo: photo,
        description: description,
        date: date,
        location: location,
      );
}
