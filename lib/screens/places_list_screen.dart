import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places_providers.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('whow'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeNamed);
            },
          ),
        ],
      ),
      body: Consumer<GreatPlaces>(
        builder: (ctx, gp, ch) => gp.items.isEmpty
            ? ch
            : ListView.builder(
                itemCount: gp.items.length,
                itemBuilder: (ctx2, index) {
                  return ListTile(title: Text(gp.items[index].title));
                }),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
