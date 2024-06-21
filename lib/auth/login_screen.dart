import 'package:auth_firebase/auth/auth_service.dart';
import 'package:auth_firebase/auth/forgot_password.dart';
import 'package:auth_firebase/auth/phone_login_screen.dart';
import 'package:auth_firebase/auth/signup_screen.dart';
import 'package:auth_firebase/widgets/button.dart';
import 'package:auth_firebase/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final _auth = AuthService();

  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SwiftAssist",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellowAccent,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const Spacer(),
            Flexible(
              flex: 8,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text("Login",
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 50),
                    CustomTextField(
                      hint: "Enter Email",
                      label: "Email",
                      controller: _email,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      hint: "Enter Password",
                      label: "Password",
                      controller: _password,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ForgotPassword()));
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.blueAccent),
                          )),
                    ),
                    const SizedBox(height: 30),
                    SignInButton(
                      Buttons.email,
                      text: "Login with Email",
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: _login,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    isLoading
                        ? const CircularProgressIndicator()
                        : SignInButton(
                      Buttons.google,
                      text: "Login with Google",
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await _auth.loginWithGoogle();
                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SignInButton(Buttons.anonymous,
                        text: "Login with Phone",
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ), onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => PhoneLoginScreen()));
                        }),
                    const SizedBox(height: 5),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text("Already have an account? "),
                      InkWell(
                        onTap: () => goToSignup(context),
                        child:
                        const Text("Signup", style: TextStyle(color: Colors.red)),
                      )
                    ]),
                  ],
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }

  goToSignup(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SignupScreen()),
  );

  _login() async {
    await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);
  }
}
