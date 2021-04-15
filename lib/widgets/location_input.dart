import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  var _locationImageUrl;

  Future<void> _getUserCoordinats() async {
    final locData = await Location().getLocation();

    print(locData.latitude);
    print(locData.longitude);
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
                icon: Icon(Icons.map), label: Text('Map'), onPressed: () {}),
          ],
        )
      ],
    );
  }
}
