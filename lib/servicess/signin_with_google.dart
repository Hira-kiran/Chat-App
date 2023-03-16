import 'package:chatapp_firebase/utills/utills.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigninClass {
  // For Login with Google
  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      Utills.snackbarrMethod(context, e.toString());
    }
    return null;
  }

  // For Logout from Google
  Future signOutGoogle() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
