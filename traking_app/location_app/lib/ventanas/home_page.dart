
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> locations = [];
  
  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocations = prefs.getStringList('locations') ?? [];
    setState(() {
      locations = savedLocations;
    });
  }

  Future<void> _saveLocation(double latitude, double longitude) async {
    final prefs = await SharedPreferences.getInstance();
    final newLocation = 'Lat: $latitude, Long: $longitude';
    final updatedLocations = [...locations, newLocation];
    await prefs.setStringList('locations', updatedLocations);
    _loadLocations();
  }

  Future<void> _getLocation() async {
    final position = await Geolocator.getCurrentPosition();
    _saveLocation(position.latitude, position.longitude);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _getLocation,
              child: const Text('LOCATION NOW'),
            ),
            const SizedBox(height: 20),
            const Text('Saved Locations:'),
            Expanded(
              child: ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(locations[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}