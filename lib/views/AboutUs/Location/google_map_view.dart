// import 'package:auster_education/views/sections/notifiers.dart';
// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

// class GoogleMapView extends StatefulWidget {
//   const GoogleMapView({Key? key}) : super(key: key);

//   @override
//   _GoogleMapViewState createState() => _GoogleMapViewState();
// }

// class _GoogleMapViewState extends State<GoogleMapView> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<LocationProvider>(context, listen: false).initilization();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: googleMap());
//   }

//   Widget googleMap() {
//     return Consumer<LocationProvider>(builder: (context, model, child) {
//       if (model.locationPosition != null) {
//         return Column(children: [
//           // Expanded(
//           //     child: GoogleMap(
//           //   mapType: MapType.normal,
//           //   initialCameraPosition: CameraPosition(
//           //     target: LatLng(19.0539983, 72.8372217),
//           //     zoom: 18,
//           //   ),
//           //   myLocationEnabled: true,
//           //   myLocationButtonEnabled: true,
//           //   onMapCreated: (GoogleMapController controller) {},
//           // ))
//         ]);
//       }
//       return Container(
//         child: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     });
//   }
// }
