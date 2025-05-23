// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyABAhhUlFVyZ3lP_ZMZxN_BGCHUo-fkxsI',
    appId: '1:684396201091:web:7e3463007c0576fe9b07b6',
    messagingSenderId: '684396201091',
    projectId: 'task-management-cf768',
    authDomain: 'task-management-cf768.firebaseapp.com',
    storageBucket: 'task-management-cf768.firebasestorage.app',
    measurementId: 'G-QRSSBE2X9M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC07AcWHwVq8OjUnBn8OEshny8Hb5ckDOQ',
    appId: '1:684396201091:android:0a9bce493b73f9e79b07b6',
    messagingSenderId: '684396201091',
    projectId: 'task-management-cf768',
    storageBucket: 'task-management-cf768.firebasestorage.app',
  );

}