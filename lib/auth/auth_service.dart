import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  Future<void> sendEmailVerificationLink() async{
    try{
      await _auth.currentUser?.sendEmailVerification();
    }catch(e){
      print(e.toString());
    }
  }
  Future<void> sendPasswordResetLink(String email) async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      exceptionHandler(e.code);
      return null; // Or throw an appropriate exception for user handling
    } catch (e) {
      log("An unexpected error occurred: $e");
      return null; // Or throw an appropriate exception for user handling
    }
  }

  Future<UserCredential?> loginWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      return _auth.signInWithCredential(cred);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      exceptionHandler(e.code);
      return null; // Or throw an appropriate exception for user handling
    } catch (e) {
      log("An unexpected error occurred: $e");
      return null; // Or throw an appropriate exception for user handling
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("An unexpected error occurred during signout: $e");
    }
  }

  void exceptionHandler(String code) {
    switch (code) {
      case "invalid-credential":
        log("Your login credentials are invalid.");
        break;
      case "weak-password":
        log("Password must be at least 8 characters.");
        break;
      case "email-already-in-use":
        log("The email address is already in use by another account.");
        break;
      case "user-disabled":
        log("The user account has been disabled.");
        break;
      case "user-not-found":
        log("The user account does not exist.");
        break;
      case "wrong-password":
        log("The password is invalid for this email.");
        break;
      case "too-many-requests":
        log("Too many requests have been made to the server. Please try again later.");
        break;
      case "operation-not-allowed":
        log("This operation is not allowed. This can happen if you are trying to access an account from an unauthorized source.");
        break;
      default:
        log("An unknown error occurred: $code");
    }
  }
}
