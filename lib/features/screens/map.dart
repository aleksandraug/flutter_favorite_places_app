import 'package:favourite_places_app/core/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget{

  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      address: '', 
      latitude: 37.422, 
      longitude: -122.084),
      this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen>{

  LatLng? _pickedLocation;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting ? 'Pick your location' : 'Your location'),
        actions: [
          if(widget.isSelecting)
            IconButton(
              onPressed: (){
                Navigator.of(context).pop(_pickedLocation); 
              },
              icon: const Icon(Icons.save)
            )
        ],
      ),
      body: GoogleMap(
        onTap: widget.isSelecting == false ? null : (position){
            setState(() {
              _pickedLocation = position;
            });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.latitude, widget.location.longitude),
          zoom: 16,
        ),
        markers: (_pickedLocation == null && widget.isSelecting) ? {} :{
          Marker(
            markerId: const MarkerId('m1'),
            position: _pickedLocation ?? LatLng(widget.location.latitude, widget.location.longitude),
            )
        },
      ),
    );
  }

}