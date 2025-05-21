import 'dart:io';

import 'package:favourite_places_app/core/models/place.dart';
import 'package:favourite_places_app/features/provider/users_places.dart';
import 'package:favourite_places_app/features/widgets/image_input.dart';
import 'package:favourite_places_app/features/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget{

  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen>{

  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _savePlace(){
    final enteredText = _titleController.text;

    if( enteredText.isEmpty || _selectedImage == null || _selectedLocation == null){
      return;
    }
    ref.read(userPlaceProvider.notifier).addPlace(enteredText, _selectedImage!, _selectedLocation!);
    Navigator.of(context).pop();

  }


  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 18,),
            ImageInput(onPickImage: (image){
              _selectedImage = image;
            },),
            const SizedBox(height: 18,),
            LocationInput(onSelectLocation: (location){
                _selectedLocation = location;
            },),
            const SizedBox(height: 18,),
            ElevatedButton.icon(
              onPressed: _savePlace,
              label: const Text('Add place'),
              icon: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }

}