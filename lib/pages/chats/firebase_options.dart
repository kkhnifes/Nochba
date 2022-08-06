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
        return macos;
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
    apiKey: 'AIzaSyBOBJjT_z-JX3S_hU30WcePwLnEo4ifjiU',
    appId: '1:1055122223825:web:0117d17bcad98db0a6cbf0',
    messagingSenderId: '1055122223825',
    projectId: 'fir-chat-549ff',
    authDomain: 'fir-chat-549ff.firebaseapp.com',
    storageBucket: 'fir-chat-549ff.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB1mGYrA18ahhXYUc5C1qbB-ANfOxTa_yk',
    appId: '1:1055122223825:android:64345d9aec3b7d51a6cbf0',
    messagingSenderId: '1055122223825',
    projectId: 'fir-chat-549ff',
    storageBucket: 'fir-chat-549ff.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOLwBp_hkfkJViBVTGkBRhWXNeUq0MgIw',
    appId: '1:1055122223825:ios:8f1758b5e3e3f03ea6cbf0',
    messagingSenderId: '1055122223825',
    projectId: 'fir-chat-549ff',
    storageBucket: 'fir-chat-549ff.appspot.com',
    iosClientId: '1055122223825-74iumuce2istudljh6u1qbu2pfg44ku8.apps.googleusercontent.com',
    iosBundleId: 'com.example',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDOLwBp_hkfkJViBVTGkBRhWXNeUq0MgIw',
    appId: '1:1055122223825:ios:8f1758b5e3e3f03ea6cbf0',
    messagingSenderId: '1055122223825',
    projectId: 'fir-chat-549ff',
    storageBucket: 'fir-chat-549ff.appspot.com',
    iosClientId: '1055122223825-74iumuce2istudljh6u1qbu2pfg44ku8.apps.googleusercontent.com',
    iosBundleId: 'com.example',
  );
}
