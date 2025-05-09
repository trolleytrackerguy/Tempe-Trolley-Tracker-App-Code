/*import 'package:flutter/material.dart';

class mainscreen extends StatelessWidget {
  const mainscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      child: Text('Tempe Trolley Tracker'),
    );
  }
}

*/


/*
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late GoogleMapController mapController;

  // Initial position for the map (Tempe, AZ)
  final LatLng _center = const LatLng(33.4255, -111.9400);

  // Markers for trolley stations
  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('station1'),
      position: LatLng(33.4255, -111.9400),
      infoWindow: InfoWindow(title: 'Tempe Station 1', snippet: 'Main Station'),
    ),
    const Marker(
      markerId: MarkerId('station2'),
      position: LatLng(33.4220, -111.9500),
      infoWindow:
          InfoWindow(title: 'Tempe Station 2', snippet: 'Downtown Stop'),
    ),
    const Marker(
      markerId: MarkerId('station3'),
      position: LatLng(33.4300, -111.9350),
      infoWindow:
          InfoWindow(title: 'Tempe Station 3', snippet: 'University Stop'),
    ),
  };

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tempe Trolley Tracker'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Tempe Trolley Tracker',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 14.0,
              ),
              markers: _markers,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Traveling Direction of Trolley',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

*/