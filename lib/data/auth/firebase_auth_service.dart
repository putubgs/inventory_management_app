import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  final clientId =
      '317544773897-im2i264kccl24am279phs3cecrigdqrp.apps.googleusercontent.com';
  final serverClientId =
      '317544773897-vt07qvrfpp9cqv9anb47qosighjdctrr.apps.googleusercontent.com';

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return credential;
  }

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    return credential;
  }

  Future<UserCredential?> signInWithGoogle() async {
    unawaited(googleSignIn.initialize(
        clientId: clientId, serverClientId: serverClientId));

    final GoogleSignInAccount googleUser =
        await googleSignIn.authenticate();

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return await firebaseAuth.signInWithCredential(credential);
  }

  Stream<User?> checkUserSignInState() {
    final state = firebaseAuth.authStateChanges();

    return state;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}
