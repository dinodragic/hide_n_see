import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:flutter_application_1/toast.dart';
import 'package:geocoding/geocoding.dart' show Placemark, placemarkFromCoordinates;

class MapSample extends StatefulWidget {
<<<<<<< HEAD
  const MapSample(
      {super.key,
      required this.username,
      required this.ip,
      required this.seeker,
      required this.radius,
      required this.timeInterval});
=======

  const MapSample({
    super.key,
    required this.username,
    required this.ip,

    required this.startLoc,
    required this.radius,
    required this.timeInterval,
    required this.seeker,
    });
>>>>>>> bc81dae (Mlslm da sve sad radi! :))

  final String username;
  final String ip;

  final String startLoc;
  final double radius;
  final int timeInterval;
  final String seeker;

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
  Map<String, dynamic> userLocations = {};

<<<<<<< HEAD
>>>>>>> cb08bef (postavljanje vlastite lokacije na server)
=======


  final Completer<GoogleMapController> _controller = Completer();
  
  
  
>>>>>>> a661eae (slanje vlastite lokacije na server)
  @override
  void initState() {
    getCurrentLocation();
    super.initState();

    _currentCircleRadius = widget.radius;
    List<String> coords = widget.startLoc.split(" ");
    _circlePosition = LatLng(double.parse(coords[0]), double.parse(coords[1]));

    
    Timer.periodic(const Duration(seconds: 10), (Timer timer) async{
      // call function to update user locations
      sendMyLocation();
    });
  }




  // BUILD !!!
  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {};

    int i=0;
    for (var location in userLocations.entries) {
      if(location.value["location"] != null && location.key != widget.username){
        
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

      body: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _circlePosition, // camera position to the circle's position
          zoom: defaultZoom,
        ),
        onMapCreated: (mapController) {
          _controller.complete(mapController);
>>>>>>> a661eae (slanje vlastite lokacije na server)
        },
<<<<<<< HEAD
        markers: {
          Marker(
            markerId: const MarkerId("MyMarker"),
            position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!)
          )
=======
        markers: markers,
        circles: <Circle>{
          Circle(
            circleId: const CircleId("Zona"),
            center:
                _circlePosition, // center of the circle to the circle's position(player0 start position)
            radius: _currentCircleRadius * 1000,
            fillColor: Colors.red.withOpacity(0.3),
            strokeColor: Colors.red,
            strokeWidth: 2,
          ),
>>>>>>> bc81dae (Mlslm da sve sad radi! :))
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.extended(
<<<<<<< HEAD
<<<<<<< HEAD
        onPressed: () => goToLoc(LatLng(currentLocation!.latitude!, currentLocation!.longitude!)),
        label: const Text('My Location'),
=======
        onPressed: () => getOtherLocations(),
=======
        onPressed: getOtherLocations,
>>>>>>> bc81dae (Mlslm da sve sad radi! :))
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

  void sendMyLocation() async {
    LocationData currentLocation = await Location().getLocation();
    String myLocation = "${currentLocation.latitude} ${currentLocation.longitude}";
    
    List<String> myCoords = myLocation.split(" ");
    List<Placemark> placemarks = await placemarkFromCoordinates(double.parse(myCoords[0]), double.parse(myCoords[1]));
    String myAddress = placemarks[0].street ?? "";

    Map body = {
      "username": widget.username,
      "location": myLocation,
      "address": myAddress
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
