typedef UserID = String;

class AppUser {
  const AppUser({
    required this.uid,
    this.email,
    this.emailVerified = false,
  });
  final UserID uid;
  final String? email;
  final bool emailVerified;

  Future<void> sendEmailVerification() async {}

  Future<bool> isAdmin() {
    return Future.value(false);
  }

  Future<void> forceRefreshIdToken() async {}

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser && other.uid == uid && other.email == email;
  }

  @override
  int get hashCode => uid.hashCode ^ email.hashCode;

  @override
  String toString() => 'AppUser(uid: $uid, email: $email)';
}
