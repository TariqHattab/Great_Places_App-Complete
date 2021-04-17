import 'package:flutter/material.dart';
import 'package:great_places_app/helpers/db_helper.dart';
import 'package:great_places_app/providers/great_places_providers.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:great_places_app/screens/place_detail_screen.dart';
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
      body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Consumer<GreatPlaces>(
                builder: (ctx, gp, ch) => gp.items.isEmpty
                    ? ch
                    : ListView.builder(
                        itemCount: gp.items.length,
                        itemBuilder: (ctx2, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(gp.items[index].image),
                            ),
                            title: Text(gp.items[index].title),
                            subtitle: Text(
                              gp.items[index].location.address,
                              softWrap: false,
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  PlaceDetailScreen.routeName,
                                  arguments: gp.items[index].id);
                            },
                          );
                        }),
                child: Center(
                  child: Text("no places added yet start adding places now"),
                ),
              );
            }
          }),
    );
  }
}
