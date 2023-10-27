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
    apiKey: 'AIzaSyAM5cAnST7wxlZ9L9A4oETTQPOGIfIrLWg',
    appId: '1:1065589913548:web:42715b96fed63a1bc5cf69',
    messagingSenderId: '1065589913548',
    projectId: 'foodtelligencev0',
    authDomain: 'foodtelligencev0.firebaseapp.com',
    storageBucket: 'foodtelligencev0.appspot.com',
    measurementId: 'G-FZZ5ZH6T4P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACxMSPHjOoSr2VM9OnsGb6TZAgE3hRD30',
    appId: '1:1065589913548:android:029f0312c10dfd41c5cf69',
    messagingSenderId: '1065589913548',
    projectId: 'foodtelligencev0',
    storageBucket: 'foodtelligencev0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBiwIL36lPjMNCsAXkRa-CceJlUkV6Se1A',
    appId: '1:1065589913548:ios:0dfe8e158186259dc5cf69',
    messagingSenderId: '1065589913548',
    projectId: 'foodtelligencev0',
    storageBucket: 'foodtelligencev0.appspot.com',
    iosClientId:
        '1065589913548-0qusrpq1mkn8bv7p3ab7l9gcb141mtve.apps.googleusercontent.com',
    iosBundleId: 'com.foodtelligence.foodtelligence',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBiwIL36lPjMNCsAXkRa-CceJlUkV6Se1A',
    appId: '1:1065589913548:ios:8fa329d3dc87656dc5cf69',
    messagingSenderId: '1065589913548',
    projectId: 'foodtelligencev0',
    storageBucket: 'foodtelligencev0.appspot.com',
    iosClientId:
        '1065589913548-vgm1nu8oev6b6mstpgrq8octmdp361ka.apps.googleusercontent.com',
    iosBundleId: 'com.foodtelligence.foodtelligence.RunnerTests',
  );
}