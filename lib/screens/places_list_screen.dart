import 'package:flutter/material.dart';
import 'package:my_places/providers/great_places.dart';
import 'package:provider/provider.dart';

import '../screens/add_place_screen.dart';
import '../screens/place_details_screen.dart';

class PlaceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.rounteName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatPlaces>(
                  child: const Center(
                    child: Text('Got no places yet'),
                  ),
                  builder: (ctx, places, child) => places.items.isEmpty
                      ? child!
                      : ListView.builder(
                          itemCount: places.items.length,
                          itemBuilder: (ctx, index) {
                            final currentPlace = places.items[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(currentPlace.image),
                              ),
                              title: Text(currentPlace.title),
                              subtitle: Text(currentPlace.location.address),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    PlaceDetaiScreen.routeName,
                                    arguments: currentPlace.id);
                              },
                            );
                          },
                        ),
                ),
        ),
      ),
    );
  }
}
