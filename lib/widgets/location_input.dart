import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  const LocationInput(this.onSelectPlace, {Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double latitude, double longitude) {
    try {
      final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
          latitude: latitude, longitute: longitude);

      setState(() {
        _previewImageUrl = staticMapImageUrl;
      });
      widget.onSelectPlace(latitude, longitude);
    } catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng? selectedLocation =
        await Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => const MapScreen(
                  isSelecting: true,
                )));
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);

    //print(selectedLocation!.latitude);
  }

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    if (locData.longitude != null && locData.latitude != null) {
      _showPreview(locData.latitude!, locData.longitude!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl == null
              ? const Text('No location chosen')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: _getCurrentUserLocation,
                icon: const Icon(Icons.location_on),
                label: const Text('Current Location')),
            TextButton.icon(
                onPressed: _selectOnMap,
                icon: const Icon(Icons.map),
                label: const Text('Select on Map'))
          ],
        )
      ],
    );
  }
}
