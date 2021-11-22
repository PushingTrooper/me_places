import 'package:flutter/material.dart';

import '../screens/add_place_screen.dart';

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
      body: Center(child: CircularProgressIndicator(),),
    );
  }
}
