// import 'dart:io';
// import 'package:event_management_app/screens/profilescreen/profile_menu.dart';
//
// import '../../models/user.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../utility/sizes.dart';
// import '../reusable/circular_image.dart';
// import '../reusable/section_heading.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   File? _imageFile;
//   String? _imageUrl;
//   late User _user;
//
//   final picker = ImagePicker();
//
//    @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(TSizes.defaultSpace),
//           child: Column(
//             children: [
//               // Display CircularImage with uploaded image or default image
//               SizedBox(
//                 width: double.infinity,
//                 child: Column(
//                   children: [
//                     CircularImage(
//                       image: _imageUrl != null ? NetworkImage(_imageUrl!) : AssetImage(AppImages.user),
//                       width: 100,
//                       height: 100,
//                     ),
//                     TextButton(
//                       onPressed: (){},
//                       child: Text('Change Profile Picture'),
//                     ),
//                   ],
//                 ),
//               ),
//
//               /// --- Details
//               const SizedBox(height: TSizes.spaceBtwItems / 2),
//               const Divider(),
//               const SizedBox(height: TSizes.spaceBtwItems),
//               const TSectionHeading(title: 'Profile Information', showActionButton: false),
//               const SizedBox(height: TSizes.spaceBtwItems),
//
//               TProfileMenu(title: 'Name', value: _user.name, onPressed: () {}),
//
//               const SizedBox(height: TSizes.spaceBtwItems),
//               const Divider(),
//               const SizedBox(height: TSizes.spaceBtwItems),
//
//               /// Heading Personal Information
//               const TSectionHeading(title: 'Personal Information', showActionButton: false),
//               const SizedBox(height: TSizes.spaceBtwItems),
//
//               TProfileMenu(onPressed: () {}, title: 'User ID', value: _user.userId, icon: Iconsax.copy),
//               TProfileMenu(onPressed: () {}, title: 'E-mail', value: _user.email),
//               TProfileMenu(onPressed: () {}, title: 'Phone Number', value: _user.phoneNumber),
//               const Divider(),
//               const SizedBox(height: TSizes.spaceBtwItems),
//
//               Center(
//                 child: TextButton(
//                   onPressed: () {},
//                   child: Text(
//                     "Close Account",
//                     style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.red),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }