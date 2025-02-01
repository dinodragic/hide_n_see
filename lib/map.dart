import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:flutter_application_1/toast.dart';

class MapSample extends StatefulWidget {
  const MapSample(
      {super.key,
      required this.username,
      required this.ip,
      required this.seeker,
      required this.radius,
      required this.timeInterval});

  final String username;
  final String ip;
  final bool seeker;
  final double radius;
  final int timeInterval;

  @override
  State<MapSample> createState() => MapSampleState();
}


// STATE!!!
class MapSampleState extends State<MapSample> {
  
  static const double defaultZoom = 15.0;
<<<<<<< HEAD


  LocationData? currentLocation;
  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: defaultZoom,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
        setState(() {});
      },
    );
  }

<<<<<<< HEAD
=======


  double _currentCircleRadius = 0.0;

  LatLng _circlePosition = const LatLng(0, 0);

  List<Map<String, dynamic>> userLocations = [];

  List<BitmapDescriptor> pinIcons = [
=======
  final List<BitmapDescriptor> pinIcons = [
>>>>>>> a661eae (slanje vlastite lokacije na server)
    BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
    BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
    BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
  ];

  double _currentCircleRadius = 0.0;
  LatLng _circlePosition = const LatLng(0, 0);
  Map<String, Map<String, String>> userLocations = {};
  LocationData? currentLocation;

<<<<<<< HEAD
>>>>>>> cb08bef (postavljanje vlastite lokacije na server)
=======


  final Completer<GoogleMapController> _controller = Completer();
  
  
  
>>>>>>> a661eae (slanje vlastite lokacije na server)
  @override
  void initState() {
    getCurrentLocation();
    super.initState();

    getCurrentLocation();

    _currentCircleRadius = widget.radius;
    _circlePosition = LatLng(currentLocation!.latitude!, currentLocation!.longitude!);

    
    Timer.periodic(const Duration(seconds: 10), (Timer timer) async{
      // call function to update user locations
      sendMyLocation();
      //getOtherLocations(url);
    });
  }




  // BUILD !!!
  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {};

    // add other users
    int i=0;
    for (var location in userLocations.entries) {
      if(location.value["location"] != null){
        
        List<String> coords = location.value["location"]!.split(" ");
        LatLng latLng = LatLng(double.parse(coords[0]), double.parse(coords[1]));
        
        i++;
        var pinIcon = pinIcons[i % pinIcons.length];

        markers.add(
          Marker(
            markerId: MarkerId(location.key),
            position: latLng,
            infoWindow: InfoWindow(
              title: location.key,
              snippet: location.value["address"]
              ),
            icon: pinIcon,
          ),
        );
      }
    }
    return Scaffold(
<<<<<<< HEAD
      body: currentLocation == null
        ? const Center(child: Text("Loading"))
        : GoogleMap(
        mapType: MapType.normal, //hybrid
        initialCameraPosition: CameraPosition(
            bearing: 0.0,
            target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            tilt: 0.0,
            zoom: defaultZoom
            ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
=======

      body: currentLocation == null
      //poboljsat loading screen treba
      ? const Center(child: Text("Loading"))
      : GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _circlePosition, // camera position to the circle's position
          zoom: defaultZoom,
        ),
        onMapCreated: (mapController) {
          _controller.complete(mapController);
>>>>>>> a661eae (slanje vlastite lokacije na server)
        },
        markers: {
          Marker(
            markerId: const MarkerId("MyMarker"),
            position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!)
          )
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
<<<<<<< HEAD
        onPressed: () => goToLoc(LatLng(currentLocation!.latitude!, currentLocation!.longitude!)),
        label: const Text('My Location'),
=======
        onPressed: () => getOtherLocations(),
        label: const Text('Get locations'),
>>>>>>> a661eae (slanje vlastite lokacije na server)
        icon: const Icon(Icons.gps_fixed),
      ),
    );
  }

<<<<<<< HEAD
  Future<void> goToLoc(LatLng pos) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            bearing: 0.0, target: pos, tilt: 0.0, zoom: defaultZoom)));
=======

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );

    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        setState(() {});
      },
    );
  }

  void sendMyLocation() async {

    Map body = {
      "username": widget.username,
      "location": "${currentLocation!.latitude!} ${currentLocation!.longitude!}",
      //mozda dodam address ak mi se bude dalo :/
      "address": ""
    };

    Uri url = Uri.http("${widget.ip}:8000", "locations");
    http.Response? response;
    try{
      response = await http.post(url, body: body);
    } catch (err){
      toast("Server nije pronađen");
    }
      
    if(response != null && response.statusCode == 400){
      toast("Nije moguće poslati lokaciju");
    }
  }

  void getOtherLocations() async {
    Uri url = Uri.http("${widget.ip}:8000", "locations");
    http.Response? response;

    try{
      response = await http.get(url);
    } catch (err){
      toast("Server nije pronađen");
    }

    if(response != null){
      if(response.statusCode == 200){
        var locations = jsonDecode(response.body);
        setState(() {
          userLocations = locations;
        });
      }
      else{
        toast("Nije moguće primiti lokacije");
      }
    }
  }

  void updateCircleRadius(double newRadius) {
    setState(() {
      _currentCircleRadius = newRadius;
    });
>>>>>>> cb08bef (postavljanje vlastite lokacije na server)
  }
}
