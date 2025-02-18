import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({
    super.key,
    required this.onSelectImage,
  });

  final void Function(File image) onSelectImage;

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _pickedImage;

  void _takePicture() async {
    ImagePicker imagePicker = ImagePicker();

    final image = await imagePicker.pickImage(source: ImageSource.gallery,);
    if (image == null) {
      return;
    }

    _pickedImage = File(image.path);

    setState(() {
      widget.onSelectImage(_pickedImage!);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takePicture,
      label: const Text('Take Picture'),
      icon: const Icon(Icons.camera),
    );

    if (_pickedImage != null) {
      content = Image.file(
        _pickedImage!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(.2),
        ),
      ),
      width: double.infinity,
      height: 250,
      alignment: Alignment.center,
      child: content,
    );
  }
}
