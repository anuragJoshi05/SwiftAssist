import 'package:auth_firebase/auth/auth_service.dart';
import 'package:auth_firebase/widgets/button.dart';
import 'package:auth_firebase/widgets/textfield.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Enter email to send you a password reset email"),
            const SizedBox(height: 20.0),
            CustomTextField(
                controller: _email, hint: "Enter Email", label: "Email"),
            const SizedBox(
              height: 20.0,
            ),
            CustomButton(
              label: "Send Email",
              onPressed: () async{
                await _auth.sendPasswordResetLink(_email.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Password reset email sent. Check your inbox.")),
                );
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
