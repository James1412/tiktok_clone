// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repo/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideoRepository _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(videosRepo);
  }

  Future<void> uploadVideo(File video, BuildContext context) async {
    final user = ref.read(authRepo).user;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final task = await _repository.uploadVideoFile(video, user!.uid);
      if (task.metadata != null) {
        await _repository.saveVideo(
          VideoModel(
            creator: "james",
            description: "Hell Yea",
            fileUrl: task.ref.getDownloadURL().toString(),
            thumbnailUrl: "",
            likes: 0,
            comments: 0,
            creatorUid: user.uid,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            title: "Hello Flutter",
          ),
        );
        context.pushReplacement('/');
      }
    });
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);
