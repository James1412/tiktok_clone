import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create profile
  Future<void> createProfile(UserProfileModel user) async {}
  // Get profile
}

final userRepo = Provider((ref) => UserRepository());
