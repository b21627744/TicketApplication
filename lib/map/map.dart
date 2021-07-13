import 'dart:math';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ticket_application/views/expeditionSearch.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double _originLatitude = ExpeditionSearchState.departure.latitude,
      _originLongitude = ExpeditionSearchState.departure.longitude;
  double _destLatitude = ExpeditionSearchState.destination.latitude,
      _destLongitude = ExpeditionSearchState.destination.longitude;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyB-hjDxDqZbJboc82-H2VGHm2PzhklPEYw";
  late GoogleMapController mapController;

  Completer<GoogleMapController> _controller = Completer();
  // ignore: avoid_init_to_null
  Marker? _departure = null;
  // ignore: avoid_init_to_null
  Marker? _destination = null;
  // ignore: avoid_init_to_null
  double _info = 0;

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getPolyline();
  }

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    mapController.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    print(l1.toString());
    print(l2.toString());
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90)
      check(u, c);
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    _controller.complete(controller);

    LatLngBounds bound = LatLngBounds(
        southwest: LatLng(min(_originLatitude, _destLatitude),
            min(_originLongitude, _destLongitude)),
        northeast: LatLng(max(_originLatitude, _destLatitude),
            max(_originLongitude, _destLongitude)));

    CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 60);
    Future.delayed(Duration(milliseconds: 150), () {
      this.mapController.animateCamera(u2).then((void v) {
        check(u2, this.mapController);
      });
    });
  }

  Marker _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
        markerId: markerId,
        icon: descriptor,
        position: position,
        onTap: () {
          mapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: position, zoom: 10, tilt: 90.0)));
        });
    markers[markerId] = marker;
    return marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.blue,
        points: polylineCoordinates,
        width: 4);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    _info = (Geolocator.distanceBetween(
            _originLatitude, _originLongitude, _destLatitude, _destLongitude) /
        1000);
    print(Geolocator.distanceBetween(
            _originLatitude, _originLongitude, _destLatitude, _destLongitude) /
        1000);
    await addmarkers();
    polylineCoordinates.add(LatLng(_originLatitude, _originLongitude));
    polylineCoordinates.add(LatLng(_destLatitude, _destLongitude));
    _addPolyLine();
  }

  onTapDestDep(Marker? marker) =>
      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: marker!.position, zoom: 10, tilt: 90.0)));

  Future<void> addmarkers() async {
    BitmapDescriptor depIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)), 'assets/driving.png');
    BitmapDescriptor destIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)), 'assets/destination.png');

    _departure = _addMarker(
        LatLng(_originLatitude, _originLongitude), "departure", depIcon);
    _destination = _addMarker(
        LatLng(_destLatitude, _destLongitude), "destination", destIcon);
  }

  Widget btnAppBarActions(Color color, Marker? marker, String text) {
    return TextButton(
        onPressed: () => onTapDestDep(marker),
        style: TextButton.styleFrom(
            primary: color,
            textStyle: const TextStyle(fontWeight: FontWeight.w600)),
        child: Text(text));
  }

  Widget distanceWidget() {
    return Positioned(
        top: 20.0,
        child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
            decoration: BoxDecoration(
                color: Colors.yellowAccent,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0)
                ]),
            child: Text(_info.toStringAsFixed(2) + " km",
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.w600))));
  }

  Widget googleMapWidget() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
          target: LatLng(((_originLatitude + _destLatitude) / 2),
              ((_originLongitude + _destLongitude) / 2)),
          zoom: 5),
      myLocationEnabled: true,
      tiltGesturesEnabled: true,
      compassEnabled: true,
      scrollGesturesEnabled: true,
      zoomGesturesEnabled: true,
      onMapCreated: _onMapCreated,
      markers: Set<Marker>.of(markers.values),
      polylines: Set<Polyline>.of(polylines.values),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                centerTitle: false,
                title: const Text('Google Maps'),
                actions: [
                  if (_departure != null)
                    btnAppBarActions(Colors.green, _departure, 'DEP.'),
                  if (_destination != null)
                    btnAppBarActions(Colors.blue, _destination, 'DEST.'),
                ]),
            body: Stack(alignment: Alignment.center, children: [
              googleMapWidget(),
              distanceWidget(),
            ])));
  }
}

    /*return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Google Maps'),
        actions: [
          if (_origin != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _origin!.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.green,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('ORIGIN'),
            ),
          if (_destination != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _destination!.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.blue,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('DEST'),
            )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {
              if (_origin != null) _origin!,
              if (_destination != null) _destination!
            },
            polylines: {
              if (_info != null)
                Polyline(
                  polylineId: PolylineId('overview_polyline'),
                  color: Colors.red,
                  width: 5,
                  points: _info!.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                ),
            },
            //onLongPress: _addMarker,
          ),
          if (_info != null)
            Positioned(
              top: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${_info!.totalDistance}, ${_info!.totalDuration}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          _info != null
              ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)
              : CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );*/
 

  /* void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        _origin = Marker(
          markerId: MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        // Reset destination
        _destination = null;

        // Reset info
        _info = null;
      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
          markerId: MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });

      // Get directions
      final directions = await DirectionsRepository(dio: null)
          .getDirections(origin: _origin!.position, destination: pos);
      setState(() => _info = directions);
    }
  }*/
