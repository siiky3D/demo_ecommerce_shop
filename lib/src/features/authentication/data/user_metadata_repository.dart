import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/src/features/authentication/domain/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_metadata_repository.g.dart';

class UserMetadataRepository {
  const UserMetadataRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Stream<DateTime?> watchUserMetadata(UserID uid) {
    final ref = _firestore.doc('metadata/$uid');
    return ref.snapshots().map((snapshot) {
      final data = snapshot.data();
      final refreshTime = data?['refreshTime'];
      if (refreshTime is Timestamp) {
        return refreshTime.toDate();
      } else {
        return null;
      }
    });
  }
}

@Riverpod(keepAlive: true)
UserMetadataRepository userMetadataRepository(Ref ref) {
  return UserMetadataRepository(FirebaseFirestore.instance);
}
