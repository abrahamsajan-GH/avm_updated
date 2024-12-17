// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options_prod.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdin4urfjAI0ty8Eg-5rf2gIiWERmTTI8',
    appId: '1:729805354350:android:754c03024705e0e212fd7f',
    messagingSenderId: '729805354350',
    projectId: 'avme-2c4d0',
    storageBucket: 'avme-2c4d0.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBV6-cCJOJdGcwaWtDcBqxPAzvnoPpisd0',
    appId: '1:729805354350:ios:fc54c611a745356d12fd7f',
    messagingSenderId: '729805354350',
    projectId: 'avme-2c4d0',
    storageBucket: 'avme-2c4d0.firebasestorage.app',
    androidClientId: '729805354350-0l3lr56pn65gs7c13b300i6tou71eg4g.apps.googleusercontent.com',
    iosClientId: '729805354350-ustaeisio9l9ndpim7ndmbii28vebkde.apps.googleusercontent.com',
    iosBundleId: 'com.craftech360.avm',
  );
}
