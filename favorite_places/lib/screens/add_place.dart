import 'dart:io';
import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';

import 'package:favorite_places/widgets/image_input.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return AddPlaceScreenState();
  }
}

class AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  File? _pickedImage;

  PlaceLocation? selectedLocation;

  void _savePlace() {
    if (_pickedImage == null || selectedLocation == null) {
      return;
    }
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      ref.read(placesProvider.notifier).addPlace(
            _titleController.text,
            _pickedImage!,
            selectedLocation!,
          );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 30,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
                controller: _titleController,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.length >= 30) {
                    return 'Must be between 1 & 30 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ImageInput(onSelectImage: (image) {
                setState(() {
                  _pickedImage = image;
                });
              }),
              const SizedBox(height: 10),
              LocationInput(
                onPickLocation: (location) {
                  selectedLocation = location;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                label: const Text('Add Place'),
                icon: const Icon(Icons.add),
                iconAlignment: IconAlignment.start,
                onPressed: _savePlace,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
