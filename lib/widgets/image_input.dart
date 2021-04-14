import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function _onImageTaken;
  ImageInput(this._onImageTaken);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();

    var fileImage =
        await picker.getImage(source: ImageSource.camera, maxWidth: 1300);

    setState(() {
      _storedImage = File(fileImage.path);
    });

    final appDir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(fileImage.path);
    final savedImage = _storedImage.copy('${appDir.path}/$filename');
    widget._onImageTaken(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 120,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.contain,
                )
              : Text('No image was taken', textAlign: TextAlign.center),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextButton.icon(
            icon: Icon(Icons.camera),
            onPressed: _takePicture,
            label: Text('Take a picture'),
          ),
        ),
      ],
    );
  }
}
