import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/features/trip/domain/enitities/trip.dart';
import 'package:travel_app/features/trip/presentation/providers/trip_provider.dart';
import 'package:travel_app/features/trip/presentation/widgets/trip_button.dart';
import 'package:travel_app/features/trip/presentation/widgets/trip_form_field.dart';

class AddTripScreen extends ConsumerStatefulWidget {
  const AddTripScreen({super.key});

  @override
  ConsumerState<AddTripScreen> createState() => _AddTripScreenState();
}

class _AddTripScreenState extends ConsumerState<AddTripScreen> {
  final formatter = DateFormat.yMMMEd();
  final _formKey = GlobalKey<FormState>();

  late String _currentDate;

  final _titleController = TextEditingController();
  final _photosController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void initState() {
    _currentDate = formatter.format(DateTime.now()).toString();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _photosController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void showDatePickerOverlay() async {
    final DateTime now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
      initialDate: now,
    );

    if (pickedDate == null) {
      return;
    }
    setState(() {
      _dateController.text = formatter.format(pickedDate).toString();
    });
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _titleController.clear();
    _descriptionController.clear();
    //edited
    _photosController.text = 'https://res.cloudinary.com/dtljonz0f/image/upload/c_auto,ar_4:3,w_3840,g_auto/f_auto/q_auto/v1/gc-v1/london-pass/blog/london-bridge-non-editorial?_a=BAVARSAP0';
    _dateController.text = _currentDate;
    _locationController.clear();
  }

  void _addNewTrip() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newTrip = Trip(
        title: _titleController.text,
        photo: _photosController.text,
        description: _descriptionController.text,
        date: _dateController.text,
        location: _locationController.text,
      );
      ref.read(tripListNotifierProvider.notifier).addNewTrip(newTrip);
      ref.read(tripListNotifierProvider.notifier).loadTrips();
      _resetForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TripFormField(
              text: 'Title',
              controller: _titleController,
            ),
            SizedBox(height: 10),
            TripFormField(
              text: 'Description',
              controller: _descriptionController,
            ),
            SizedBox(height: 10),
            Stack(
              children: [
                TripFormField(
                  text: _dateController.text.isEmpty
                      ? _dateController.text = _currentDate
                      : _dateController.text,
                  controller: _dateController,
                  isReadOnly: true,
                ),
                Positioned(
                  right: 10,
                  top: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: showDatePickerOverlay,
                    child: Icon(
                      Icons.date_range,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            TripFormField(
              text: 'Location',
              controller: _locationController,
            ),
            SizedBox(height: 10),
            TripFormField(
              text: 'Photos',
              controller: _photosController,
            ),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TripButton(
                  clickedButton: _addNewTrip,
                  text: 'Save Trip',
                ),
                SizedBox(width: 15),
                IconButton(
                  onPressed: _resetForm,
                  icon: Icon(Icons.restart_alt_rounded),
                  color: Color.fromARGB(255, 46, 80, 119),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
