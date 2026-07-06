import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCHOGf078I9s9xUug7VkGjUOyzTmTQ7nL4',
    appId: '1:636237131515:web:placeholder',
    messagingSenderId: '636237131515',
    projectId: 'salonyonetimi-75232',
    authDomain: 'salonyonetimi-75232.firebaseapp.com',
    storageBucket: 'salonyonetimi-75232.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCHOGf078I9s9xUug7VkGjUOyzTmTQ7nL4',
    appId: '1:636237131515:android:a014ca1645a718e0920a5e',
    messagingSenderId: '636237131515',
    projectId: 'salonyonetimi-75232',
    storageBucket: 'salonyonetimi-75232.firebasestorage.app',
  );
}
