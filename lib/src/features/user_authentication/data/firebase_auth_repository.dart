import 'package:demo_app/src/constants/global_variable.dart';
import 'package:demo_app/src/utils/auth_exceptions_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_auth_repository.g.dart';

class AuthRepository {
  AuthRepository(this._auth);
  final FirebaseAuth _auth;

  Stream<User?> authStateChanges() => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<void> signInAnonymously() {
    return _auth.signInAnonymously();
  }

  Future<UserCredential?> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      final errorStatus = AuthExceptionHandler.handleAuthException(e);
      final errorMessage = AuthExceptionHandler.generateErrorMessage(errorStatus);
      logger.e("Sign in error: $errorMessage");

      throw Exception(errorMessage);
    }
  }

  Future<UserCredential?> signUpWithEmail(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      final errorStatus = AuthExceptionHandler.handleAuthException(e);
      final errorMessage = AuthExceptionHandler.generateErrorMessage(errorStatus);
      logger.e('Sign up error: $errorMessage');

      throw Exception(errorMessage);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(Ref ref) {
  return FirebaseAuth.instance;
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(firebaseAuthProvider));
}

@riverpod
Stream<User?> authStateChanges(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
}
