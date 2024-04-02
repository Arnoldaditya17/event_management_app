

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


import '../../constants/constants.dart';
import '../../models/user.dart';
import 'package:http/http.dart'as http;

import '../../utility/routes/routes_name.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final picker = ImagePicker();
  bool isUploading = false;
  String imageUrl = '';

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        isUploading = false; // Reset for potential re-upload
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

    setState(() {
      isUploading = true;
    });

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference =
    storage.ref().child('profile/${DateTime.now().toString()}');

    storageReference.putFile(_image!).whenComplete(() async {
      imageUrl = await storageReference.getDownloadURL();




      print('Image uploaded to Firestore. URL: $imageUrl');
      saveImageUrl(userId, imageUrl);
      setState(() {
        isUploading = false;

      });
    });


  }
  static Future<void> saveImageUrl(int userId, String imageUrl) async {
    final url = Constants.getUri('user/profile-photo');

    final requestBody = {
      'userId': userId,
      'imageUrl': imageUrl,

    };
    requestBody["userId"];

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to save image URL: ${response.body}');
    }
    else
      { User? obj = await Constants.getUserLocally();
        obj!.userProfile=imageUrl;
        Constants.saveUserLocally(obj);

      }

  }
  late String name;
  late String phoneNumber;
  late int userId;


  @override
  void initState() {
    super.initState();
    name = '';
    phoneNumber = '';
    userId=0;
    imageUrl='';
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final User? user = await Constants.getUserLocally();
      if (user != null) {
        setState(() {
          name = '${user.firstname} ${user.lastname}';
          phoneNumber = user.phone;
          userId= user.id;
          imageUrl=user.userProfile;
        });
      }
    } catch (e) {
      // Handle errors or show a message if data fetch fails
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          color: Colors.white60,
         elevation: 1,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white10.withOpacity(0.5),
                      ),
                      child: ClipOval(
                        child: isUploading
                            ? CircularProgressIndicator()
                            : _image != null
                            ? Image.file(
                          _image!,
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                        )
                            : imageUrl.isNotEmpty
                            ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                        )
                            : Icon(Icons.person, size: 80),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: _getImage,
                          child: Icon(
                            Icons.image,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_image != null)
                  IconButton(
                    onPressed: _uploadImageToFirestore,
                    icon: Icon(Icons.check),
                  ),

                ListTile(
                  title: Text(
                    'Name:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    name,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  title: Text(
                    'Phone Number:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    phoneNumber,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
               Constants.signOut();
               Navigator.pushReplacementNamed(context, RoutesName.login);

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(5),
                    //
                    // ),
                  ),
                  child: Text(
                    'sign out',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

