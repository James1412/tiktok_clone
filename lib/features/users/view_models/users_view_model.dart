import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _repository;

  @override
  FutureOr<UserProfileModel> build() {
    /// Fetch user's profile if already logged in
    _repository = ref.read(userRepo);
    return UserProfileModel.empty();
  }

  Future<void> createAccount(UserCredential userCredential) async {
    if (userCredential.user == null) {
      throw Exception("Account not created");
    }
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      bio: 'undefined',
      link: 'undefined',
      uid: userCredential.user!.uid,
      name: userCredential.user!.displayName ?? "Anon",
      email: userCredential.user!.email ?? "anon@anon.com",
    );
    await _repository.createProfile(profile);
    state = AsyncValue.data(profile);
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
