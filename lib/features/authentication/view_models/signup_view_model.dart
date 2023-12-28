import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repo/authentication_repo.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/utilities.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;
  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    final users = ref.read(usersProvider.notifier);
    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.emailSignUp(
        form['email'],
        form['password'],
      );
      // create profile in our db
      await users.createAccount(userCredential);
    });
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const InterestsScreen()),
      );
    }
  }
}

final signUpForm = StateProvider((ref) => {});
final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
