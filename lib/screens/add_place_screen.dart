import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places_app/helpers/location_helper.dart';
import 'package:great_places_app/models/place.dart';
import 'package:great_places_app/providers/great_places_providers.dart';
import 'package:great_places_app/widgets/image_input.dart';
import 'package:great_places_app/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeNamed = '/add_place_screen';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  var _titleController = TextEditingController();
  File _imageTaken;
  PlaceLocation _location;
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _imagePicked(File image) {
    _imageTaken = image;
  }

  void _locationPicked(double lat, double lng) {
    _location = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _onSaveImage() {
    if (_titleController.text.isEmpty ||
        _imageTaken == null ||
        _location == null) {
      print(_imageTaken);
      print('whops');
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _imageTaken, _location);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Place'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_imagePicked),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(_locationPicked),
                  ],
                ),
              ),
            ),
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              primary: Colors.white,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: ContinuousRectangleBorder(),
            ),
            onPressed: _onSaveImage,
            icon: Icon(Icons.add),
            label: Text('Add'),
          ),
        ],
      ),
    );
  }
}
