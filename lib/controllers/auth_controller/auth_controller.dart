import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_management_app/data/auth/firebase_auth_service.dart';

class AuthController {
  final FirebaseAuthService authService;
  AuthController(this.authService);

  Future<UserCredential> signIn(String email, String password) async {
    final result =
        await authService.signInWithEmailAndPassword(email, password);

    return result;
  }

  Future<UserCredential> register(String email, String password) async {
    final result =
        await authService.registerWithEmailAndPassword(email, password);

    return result;
  }

  Future<UserCredential?> signInWithGoogle() async {
    return authService.signInWithGoogle();
  }



  Future<void> signOut() async {
    await authService.signOut();
  }
}