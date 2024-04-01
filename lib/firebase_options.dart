// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAI0j3hfWy2h0KGWX1kUaWiSkCd-7yu_MU',
    appId: '1:731769170180:web:9673b7ff1e6e3724cd0851',
    messagingSenderId: '731769170180',
    projectId: 'eventmanagementsystem-2a3d9',
    authDomain: 'eventmanagementsystem-2a3d9.firebaseapp.com',
    storageBucket: 'eventmanagementsystem-2a3d9.appspot.com',
    measurementId: 'G-DF6BQSH8HQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDOeFbxHrbjXFuxJ5jVyTOenEW6cfBoCXc',
    appId: '1:731769170180:android:60d112aa57cf194dcd0851',
    messagingSenderId: '731769170180',
    projectId: 'eventmanagementsystem-2a3d9',
    storageBucket: 'eventmanagementsystem-2a3d9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDHKGETAd1sy3WAq2R61XfrJ-Gob0o_nKQ',
    appId: '1:731769170180:ios:9eebbd6d6450c019cd0851',
    messagingSenderId: '731769170180',
    projectId: 'eventmanagementsystem-2a3d9',
    storageBucket: 'eventmanagementsystem-2a3d9.appspot.com',
    iosBundleId: 'com.example.eventManagementApp',
  );
}