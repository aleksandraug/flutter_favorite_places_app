import 'dart:convert';

import 'package:favourite_places_app/features/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import 'package:favourite_places_app/core/models/place.dart';

class LocationInput extends StatefulWidget{

  const LocationInput({super.key, required this.onSelectLocation});
  
  final void Function (PlaceLocation location) onSelectLocation;

  @override
  State<LocationInput> createState() {
   return _LocationInputState();
  }

}

class _LocationInputState extends State<LocationInput>{

  PlaceLocation? _pickedLocation;
  var _isGettingLocation =false;

  String get locationImage {

    if(_pickedLocation == null){
      return ('');
      
    }

    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    final _apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];

    return ('https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$lat,$lng&key=$_apiKey');
  }

  Future<void> _savePlace(double latitude, double longitude) async{
    final _apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
    final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=${latitude},${longitude}&key=$_apiKey');

    final response = await http.get(url);

    final resData = json.decode(response.body);
    final address = resData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation = PlaceLocation(address: address, latitude: latitude, longitude: longitude);
      _isGettingLocation = false;
    });

    widget.onSelectLocation(_pickedLocation!);

  }


  void _getCurrentLocation() async{

    
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          print('null');
          return;
        }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('null');
         return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    _locationData = await location.getLocation();
    final lat = _locationData.latitude;
    final lng = _locationData.longitude;

    if (lat == null || lng ==null){
      print('null');
      return;
    }

    _savePlace(lat, lng);
  }

  void _selectOnMap () async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(builder: (ctx)=>MapScreen())
    );

    if(pickedLocation==null){
      return;
    }

    _savePlace(pickedLocation.latitude, pickedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {

    Widget previewContent =  Text(
      'No Location choosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );

    if(_pickedLocation != null ){
      previewContent = Image.network(
        locationImage, 
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    if(_isGettingLocation == true){
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary.withOpacity(0.2))
          ),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation, 
              label: const Text('Get Current Location'),
              icon: const Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: _selectOnMap, 
              label: const Text('Select on map'),
              icon: const Icon(Icons.map),
            ),
          ],
        )
      ],
    );
  }

}