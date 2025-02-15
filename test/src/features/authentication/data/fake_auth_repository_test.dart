import 'package:demo_app/src/exceptions/app_exception.dart';
import 'package:demo_app/src/features/authentication/data/fake_app_user.dart';
import 'package:demo_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  const testEmail = 'test1@gmail.com';
  const testPassword = '123456';
  final testUser = FakeAppUser(
    uid: testEmail.split('').reversed.join(),
    email: testEmail,
    password: testPassword,
  );

  FakeAuthRepository makeAuthRepository() => FakeAuthRepository(addDelay: false);
  group('FakeAuthRepository', () {
    test('currentUser is null', () {
      final authRepository = makeAuthRepository();
      addTearDown(authRepository.dispose);
      expect(authRepository.currentUser, null);
      expect(authRepository.authStateChanges(), emits(null));
    });

    test('sign in throws when user not found', () async {
      final authRepository = makeAuthRepository();
      addTearDown(authRepository.dispose);
      await expectLater(
        () => authRepository.signInWithEmailAndPassword(
          testEmail,
          testPassword,
        ),
        throwsA(isA<UserNotFoundException>()),
      );
      expect(authRepository.currentUser, null);
      expect(authRepository.authStateChanges(), emits(null));
    });
    test('currentUser is not null after registration', () async {
      final authRepository = makeAuthRepository();
      addTearDown(authRepository.dispose);
      await authRepository.createUserWithEmailAndPassword(
        testEmail,
        testPassword,
      );
      expect(authRepository.currentUser, testUser);
      expect(authRepository.authStateChanges(), emits(testUser));
    });

    test('currentUser is null after sign out', () async {
      final authRepository = makeAuthRepository();
      addTearDown(authRepository.dispose);
      await authRepository.createUserWithEmailAndPassword(
        testEmail,
        testPassword,
      );
      expect(authRepository.currentUser, testUser);
      expect(authRepository.authStateChanges(), emits(testUser));

      await authRepository.signOut();
      expect(authRepository.currentUser, null);
      expect(authRepository.authStateChanges(), emits(null));
    });

    test('create user after dispose throws exception', () {
      final authRepository = makeAuthRepository();
      authRepository.dispose();
      expect(
        () => authRepository.createUserWithEmailAndPassword(
          testEmail,
          testPassword,
        ),
        throwsStateError,
      );
    });
  });
}
