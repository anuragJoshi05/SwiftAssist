import 'dart:async';
import 'package:auth_firebase/auth/login_screen.dart';
import 'package:auth_firebase/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initializing the Firebase app with FirebaseOptions
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCpGmrzn6TFgYNKD7Dh1BRj6JSRyk7nlo0',
      appId: '1:473370088606:android:41341562a6b5d5fd21578f',
      messagingSenderId: '473370088606',
      projectId: 'fir-auth-e28c9',
      storageBucket: 'fir-auth-e28c9.appspot.com',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
    );
  }
}
