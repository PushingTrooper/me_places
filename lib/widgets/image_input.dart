import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sys_path;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput(this.onSelectImage, {key}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final imagePicker = ImagePicker();
    XFile? imageFile =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    setState(() {
      if (imageFile != null) {
        _storedImage = File(imageFile.path);
      }
    });
    final appDir = await sys_path.getApplicationDocumentsDirectory();
    if (imageFile != null) {
      final imageName = path.basename(imageFile.path);
      final savedImage = await _storedImage!.copy('${appDir.path}/$imageName');
      widget.onSelectImage(savedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  "No Image taken",
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePicture,
            icon: const Icon(Icons.camera),
            label: Text(
              'Take Picture',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        )
      ],
    );
  }
}
