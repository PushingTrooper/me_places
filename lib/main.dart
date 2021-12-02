import 'package:flutter/material.dart';
import 'package:my_places/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

import './providers/great_places.dart';
import './screens/places_list_screen.dart';
import './screens/place_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(primarySwatch: Colors.blue);

    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: themeData.copyWith(
            colorScheme:
                themeData.colorScheme.copyWith(secondary: Colors.orangeAccent)),
        home: PlaceListScreen(),
        routes: {
          AddPlaceScreen.rounteName: (ctx) => AddPlaceScreen(),
          PlaceDetaiScreen.routeName: (ctx) => PlaceDetaiScreen()
        },
      ),
    );
  }
}
