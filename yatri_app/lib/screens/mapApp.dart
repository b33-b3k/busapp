import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:yatri_app/components/navbar.dart';

class MapApp extends StatefulWidget {
  @override
  _MapAppState createState() => _MapAppState();
}

class _MapAppState extends State<MapApp> {
  double long = 85.3240;
  double lat = 27.7172;
  LatLng point = LatLng(27.7172, 85.3240);

  var location = [];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            onTap: (tapPosition, point) async {
              location = await Geocoder.local.findAddressesFromCoordinates(
                  Coordinates(point.latitude, point.longitude));

              setState(() {
                this.point = point;
                print(point);
              });
              if (location.isNotEmpty) {
                print(
                    "${location.first.countryName} - ${location.first.featureName}");
              }
            },
            center: point,
            zoom: 12.0,
          ),
          children: [
            TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  // ignore: prefer_const_constructors
                  builder: (ctx) => Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                  point: point,
                )
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 34.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                child: TextField(
                  controller: searchController,
                  onSubmitted: (value) async {
                    location =
                        await Geocoder.local.findAddressesFromQuery(value);
                    if (location.isNotEmpty) {
                      setState(() {
                        point = LatLng(location.first.coordinates.latitude,
                            location.first.coordinates.longitude);
                        searchController.clear();
                      });
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16.0),
                    hintText: "Search for your location",
                    prefixIcon: Icon(Icons.location_on_outlined),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if (location.isNotEmpty)
                        Text(
                            "${location.first.countryName},${location.first.locality}, ${location.first.featureName}"),
                    ],
                  ),
                ),
              ),
              //logout
              ElevatedButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/login');
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ),
        // const BottomBarPage()
      ],
    );
  }
}


// class MapApp extends StatefulWidget {
//   @override
//   _MapAppState createState() => _MapAppState();
// }

// class _MapAppState extends State<MapApp> {
//   double long = 49.5;
//   double lat = -0.09;
//   LatLng point = LatLng(27.7172, 85.3240);

//   var location = [];

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         FlutterMap(
//           options: MapOptions(
//             onTap: (tapPosition, point) async {
//               // location = await Geocoder.local.findAddressesFromCoordinates(
//               //     Coordinates(point.latitude, point.longitude));

//               setState(() {
//                 this.point = point;
//                 print(point);
//               });
//               if (!location.isEmpty) {
//                 print(
//                     "${location.first.countryName} - ${location.first.featureName}");
//               }
//             },
//             zoom: 5.0,
//           ),
//           children: [
//             TileLayer(
//                 urlTemplate:
//                     "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                 subdomains: ['a', 'b', 'c']),
//             MarkerLayer(
//               markers: [
//                 Marker(
//                   width: 80.0,
//                   height: 80.0,
//                   builder: (ctx) => Container(
//                     child: Icon(
//                       Icons.location_on,
//                       color: Colors.red,
//                     ),
//                   ),
//                   point: point,
//                 )
//               ],
//             ),
//           ],
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 34.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Card(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.all(16.0),
//                     hintText: "Search for your localisation",
//                     prefixIcon: Icon(Icons.location_on_outlined),
//                   ),
//                 ),
//               ),
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       if (location.isNotEmpty)
//                         Text(
//                             "${location.first.countryName},${location.first.locality}, ${location.first.featureName}"),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
