import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import "package:http/http.dart" as http;
import "dart:convert";

class GoogleMapHomeScreen extends StatefulWidget {
  const GoogleMapHomeScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapHomeScreen> createState() => _GoogleMapHomeScreenState();
}

class _GoogleMapHomeScreenState extends State<GoogleMapHomeScreen> {
  late LatLng userPosition = LatLng(51.52, -0.24);
  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Maps"), actions: <Widget>[
        IconButton(onPressed: () => findPlaces(), icon: Icon(Icons.map)),
      ]),
      body: FutureBuilder(
        future: findUserLocation(),
        builder: (BuildContext context, AsyncSnapshot<LatLng> snapshot) {
          print("shanpshot print: ${snapshot.data}");

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }

          return GoogleMap(
            markers: Set<Marker>.of(markers),
            initialCameraPosition:
                CameraPosition(target: snapshot.data!, zoom: 11),
          );
        },
      ),
    );
  }

  Future<LatLng> findUserLocation() async {
    Location location = Location();
    LocationData userLocation;

    PermissionStatus hasPermission = await location.hasPermission();
    bool active = await location.serviceEnabled();

    print("allowed: $hasPermission");
    print("active: $active");

    if (hasPermission == PermissionStatus.granted && active) {
      userLocation = await location.getLocation();
      userPosition = LatLng(userLocation.latitude!, userLocation.longitude!);

      print("position: $userPosition");
    } else {
      userPosition = LatLng(51.52, -0.24);
      setState(() {});
    }

    return userPosition;
  }

  Future findPlaces() async {
    final String key = 'AIzaSyD7oTjttFuOJNNcIzEe32NV2GBUs6kw04c';
    final String placesUrl =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?";

    String url = placesUrl +
        'key=$key&type=restaurant&location=${37.4219983.toString()},${(-122.084).toString()}' +
        '&radius=1000';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception("Unable to retrieve places");
    }

    // response body will always be a string, because http get will convert it i guess
    final data = json.decode(response.body);

    print("This is data: $data");
    showMarkers(data);
  }

  void showMarkers(dynamic data) {
    List places = data["results"];
    /*  "results": [
{
"geometry" : {
"location" : {
"lat" : 41.8998425,
"lng" : 12.499711
},
},
"name" : "UNAHOTELS Decò",
"place_id" : "ChIJk6d0a6RhLxMRVH_wYTNrTDQ",
"reference" : "ChIJk6d0a6RhLxMRVH_wYTNrTDQ",
"types" : [ "lodging", "restaurant", "food", "point_of_interest",
"establishment" ],
"vicinity" : "Via Giovanni Amendola, 57, Roma"
} */
    markers.clear();

    places.forEach((place) {
      markers.add(Marker(
          markerId: MarkerId(place["reference"]),
          position: LatLng(place["geometry"]["location"]["lat"],
              place["geometry"]["location"]["lng"]),
          infoWindow:
              InfoWindow(title: place["name"], snippet: place["vicinity"])));
    });

    setState(() {
      markers = markers;
    });
  }
}
