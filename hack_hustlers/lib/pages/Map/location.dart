import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hack_hustlers/pages/Map/AlertDialog.dart';
import 'package:latlong2/latlong.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  // Flag to indicate location fetch status
  bool _fetchedLocation = false;
  LatLng _currentLocation = LatLng(37.4219983, -122.084); // Default location

  Future<void> _fetchLocation() async {
    try {
      // Request location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        // Location permission granted
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
          _fetchedLocation = true;
        });
      } else {
        // Permission denied or undetermined, handle the case
        print('Location permission denied');
      }
    } catch (e) {
      // Handle any errors that might occur
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: _fetchedLocation
          ? FlutterMap(
              options: MapOptions(
                center: _currentLocation,
                zoom: 12.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _currentLocation,
                      builder: (ctx) => GestureDetector(
                        onTap: () {
                          print('Marker tapped at current location');
                        },
                        child: Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 40.0,
                        ),
                      ),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(19.1247, 72.8170),
                      builder: (ctx) => GestureDetector(
                        onTap: () {
                          print('Marker tapped at location 1');
                          showDataAlertWithImage(
                              context,
                              "Versova Beach",
                              "Soft sands, gentle waves, and whispering palms: Versova Beach embraces you in a soothing symphony of nature's calm.",
                              "images/Versova.jpeg");
                        },
                        child: Icon(
                          Icons.location_pin,
                          color: Colors.blue,
                          size: 40.0,
                        ),
                      ),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(19.1807, 72.8333),
                      builder: (ctx) => GestureDetector(
                        onTap: () {
                          print('Marker tapped at location 2');
                          showDataAlertWithImage(
                              context,
                              "Mind Space",
                              "A sanctuary amidst the bustling cityscape, where tranquility finds its home and the mind discovers its space to breathe",
                              "images/Mindspace.jpeg");
                        },
                        child: Icon(
                          Icons.location_pin,
                          color: Colors.blue,
                          size: 40.0,
                        ),
                      ),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(19.1115, 72.8794),
                      builder: (ctx) => GestureDetector(
                        onTap: () {
                          print('Marker tapped at location 3');
                          showDataAlertWithImage(
                              context,
                              "Pawfect",
                              "Where wagging tails and gentle purrs create a symphony of tranquility, inviting you to find peace in the unconditional love of our furry companions.",
                              "images/Pawfect.jpg");
                        },
                        child: Icon(
                          Icons.location_pin,
                          color: Colors.blue,
                          size: 40.0,
                        ),
                      ),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(19.1510, 72.8720),
                      builder: (ctx) => GestureDetector(
                        onTap: () {
                          print('Marker tapped at location 4');
                          showDataAlertWithImage(
                              context,
                              "Aarey Colony",
                              "In the heart of nature's embrace lies Aarey Milk Colony, where verdant beauty whispers serenity, and every breath is a moment of peaceful connection.",
                              "images/Aarey.jpeg");
                        },
                        child: Icon(
                          Icons.location_pin,
                          color: Colors.blue,
                          size: 40.0,
                        ),
                      ),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(19.1412, 72.8309),
                      builder: (ctx) => GestureDetector(
                        onTap: () {
                          print('Marker tapped at location 5');
                          showDataAlertWithImage(
                              context,
                              "Infinity Mall",
                              "Infinity Mall Andheri, where the bustle of the city fades into the background, and each corner unveils a sanctuary of leisure and relaxation amidst the urban hustle.",
                              "images/Infiniti.jpg");
                        },
                        child: Icon(
                          Icons.location_pin,
                          color: Colors.blue,
                          size: 40.0,
                        ),
                      ),
                    ),
                    // Add more markers as needed
                  ],
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }
}
