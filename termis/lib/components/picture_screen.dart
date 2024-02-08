import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class Picture extends StatefulWidget {
  const Picture({Key? key}) : super(key: key);

  @override
  State<Picture> createState() => _PictureState();
}

class _PictureState extends State<Picture> {
  File? _image;
  String? _location;
  TextEditingController _descriptionController = TextEditingController();

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get the current position
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 300,
            width: 400,
            child: Card(
              child: Center(
                child: _image != null
                    ? Image.file(
                        _image!,
                        height: 250,
                        width: 400,
                      )
                    : const Text("Image is not loaded"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 198, 210, 219),
              onPressed: () {
                _showImageSourceOptions();
              },
              tooltip: 'Take a Picture',
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 8.0),
                  Text('Take a Picture'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Add a description...',
                labelText: 'Description',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 198, 210, 219),
              onPressed: () {
                _showSubmitDialog();
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.send),
                  SizedBox(width: 8.0),
                  Text('Submit'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showImageSourceOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildImageSourceOptions();
      },
    );
  }

  Widget _buildImageSourceOptions() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.camera),
          title: const Text('Camera'),
          onTap: () {
            _pickImage(ImageSource.camera);
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.image),
          title: const Text('Gallery'),
          onTap: () {
            _pickImage(ImageSource.gallery);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        _setImage(File(pickedFile.path));

        // Get location after setting the image
        Position position = await _determinePosition();
        setState(() {
          _location = "(${position.latitude}, ${position.longitude})";
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void _setImage(File imageFile) {
    setState(() {
      _image = imageFile;
    });
  }

  void _showSubmitDialog() {
    print('Description: ${_descriptionController.text}');
    print('Location: $_location');
    // Add the logic to submit the data
  }
}
