import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Location location = Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  _getLocation() async {
    var serviceEnabled = await location.serviceEnabled();
    setState(() {
      _serviceEnabled = serviceEnabled;
    });
    if (!serviceEnabled) {
      return;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }

    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }

    var ld = await location.getLocation();
    setState(() {
      _locationData = ld;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_serviceEnabled == null || _serviceEnabled == false) {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text("Please enable Geolocate permission"),
            ],
          ),
        ],
      );
    }

    if (_locationData == null ||
        _locationData?.latitude == null ||
        _locationData?.longitude == null) {
      return const Center(child: Text("Now loading..."));
    }

    return Row(
      children: [
        FlutterMap(
          options: MapOptions(
            initialCenter:
                LatLng(_locationData!.latitude!, _locationData!.longitude!),
          ),
          children: const [],
        ),
        Text(
          "lat: ${_locationData!.latitude!}, lng: ${_locationData!.longitude!}",
        )
      ],
    );
  }
}
