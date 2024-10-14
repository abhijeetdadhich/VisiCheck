import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Google Sign-In
  Future<UserCredential?> signInWithGoogle() async {
    // Ensure user is signed out first to force account selection
    await signOut();

    // Begin interactive sign-in process (opens the page on Google IDs)
    final GoogleSignInAccount? gUser = await _googleSignIn.signIn();

    // Check if the sign-in was canceled or failed
    if (gUser == null) {
      return null;
    }

    // Obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    // Create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Finally, let's sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
