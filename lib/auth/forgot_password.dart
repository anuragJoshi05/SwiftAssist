import 'package:auth_firebase/auth/auth_service.dart';
import 'package:flutter/material.dart';

import '../widgets/textfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _auth = AuthService();
  final _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SwiftAssist 🚀',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 40),
        child: Column(
          children: [
            const Text(
              "Enter email to send you a password reset email",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20.0),
            CustomTextField(
              hint: "Enter Email",
              label: "Email",
              controller: _email,
              hintStyle: const TextStyle(color: Colors.white70),
              labelStyle: const TextStyle(color: Colors.white),
              textStyle: const TextStyle(color: Colors.white),
              borderRadius: 20.0,
              borderColor: Colors.white30,
              backgroundColor: Colors.white12,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                await _auth.sendPasswordResetLink(_email.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Password reset email sent. Check your inbox.")),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Button color
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              child: const Text('Send Email',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }
}
