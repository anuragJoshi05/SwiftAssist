import 'dart:async';
import 'package:auth_firebase/auth/auth_service.dart';
import 'package:auth_firebase/widgets/button.dart';
import 'package:auth_firebase/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  final User user;

  const VerificationScreen({super.key, required this.user});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final AuthService _auth = AuthService();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _auth.sendEmailVerificationLink();

    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      await widget.user.reload();
      User? updatedUser = FirebaseAuth.instance.currentUser;

      if (updatedUser != null && updatedUser.emailVerified) {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Wrapper()),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "We have sent an email for verification. If you haven't received an email, tap to resend",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                label: "Resend Email",
                onPressed: () async {
                  await _auth.sendEmailVerificationLink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
