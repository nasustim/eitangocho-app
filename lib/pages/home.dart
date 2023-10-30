import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Location location = new Location();
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
          Center(
            child: Text("Please enable Geolocate permission"),
          ),
        ],
      );
    }

    return _locationData == null
        ? const Center(child: Text("Now loading..."))
        : Center(
            child: Text(
                "lat: ${_locationData!.latitude}, lng: ${_locationData!.longitude}"));
  }
}
