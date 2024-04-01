import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImageToFirestore() async {
    if (_image == null) {
      print('No image selected.');
      return;
    }

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference =
    storage.ref().child('profile/${DateTime.now().toString()}');
    UploadTask uploadTask = storageReference.putFile(_image!);
    await uploadTask.whenComplete(() => null);
    String imageUrl = await storageReference.getDownloadURL();

    // Save the image URL to Firestore
    FirebaseFirestore.instance.collection('profile').add({
      'url': imageUrl,
    });

    print('Image uploaded to Firestore. URL: $imageUrl');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image!),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _getImage,
            tooltip: 'Pick Image',
            child: Icon(Icons.photo_library),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _uploadImageToFirestore,
            tooltip: 'Upload Image',
            child: Icon(Icons.cloud_upload),
          ),
        ],
      ),
    );
  }
}


