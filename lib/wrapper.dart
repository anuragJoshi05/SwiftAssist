import 'package:auth_firebase/auth/login_screen.dart';
import 'package:auth_firebase/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth_firebase/auth/verification_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error"),
              );
            } else {
              if (snapshot.data == null) {
                return const LoginScreen();
              } else {
                if(snapshot.data?.emailVerified==true){
                  return const HomeScreen();
                }else{
                  return VerificationScreen(
                    user:snapshot.data!, // Pass the user object here
                  );
                }
              }
            }
          }),
    );
  }
}
