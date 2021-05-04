import 'package:flutter/material.dart';
import 'package:great_places_app/models/place.dart';
import 'package:great_places_app/providers/great_places_providers.dart';
import 'package:great_places_app/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place_detail_screen';

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;
    Place place = Provider.of<GreatPlaces>(context).findById(id);
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Column(
        children: [
          Hero(
            tag: place.id,
            child: Container(
              height: 230,
              width: double.infinity,
              child: Image.file(
                place.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            place.location.address,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => MapScreen(
                        initailLocation: place.location, isSelecting: false),
                  ),
                );
              },
              child: Text('View on Map')),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
