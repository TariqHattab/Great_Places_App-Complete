import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_app/helpers/location_helper.dart';
import 'package:great_places_app/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectLocation;

  const LocationInput(this.onSelectLocation);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  var _locationImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _locationImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getUserCoordinats() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude, locData.longitude);

      widget.onSelectLocation(locData.latitude, locData.longitude);
    } catch (e) {
      print('failed to get the location');
      return;
    }
  }

  Future<void> _onMapSelected() async {
    final selectedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      builder: (ctx) => MapScreen(isSelecting: true),
    ));
    if (selectedLocation == null) {
      return;
    }

    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectLocation(
        selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _locationImageUrl == null
              ? Center(
                  child: Text('Pick a location'),
                )
              : Image.network(
                  _locationImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                icon: Icon(Icons.location_on),
                label: Text('Current location'),
                onPressed: _getUserCoordinats),
            TextButton.icon(
                icon: Icon(Icons.map),
                label: Text('Map'),
                onPressed: _onMapSelected),
          ],
        )
      ],
    );
  }
}
