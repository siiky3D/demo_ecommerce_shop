import 'package:demo_app/src/features/user_authentication/data/firebase_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<UserCredential?> signInWithEmail(String email, String password, WidgetRef ref) {
  final authRepo = ref.read(authRepositoryProvider);
  return authRepo.signInWithEmail(email, password);
}

Future<UserCredential?> signUpWithEmail(String email, String password, WidgetRef ref) {
  final authRepo = ref.read(authRepositoryProvider);
  return authRepo.signUpWithEmail(email, password);
}

Future<void> signOut(WidgetRef ref) {
  final authRepo = ref.read(authRepositoryProvider);
  return authRepo.signOut();
}
