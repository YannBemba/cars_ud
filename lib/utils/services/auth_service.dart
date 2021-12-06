import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // sign in with Google
  Future<UserCredential> signInWithGoogle() async {
    // auth flux
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // authorization details
    final googleAuth = await googleUser!.authentication;

    // new user
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);

  }

  // user log state
  Stream<User?> get user => _auth.authStateChanges();

  // log out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

}
