import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideoRepository _repository;
  List<VideoModel> _list = [];

  void uploadVideo() async {
    state = const AsyncValue.loading();
    await Future.delayed(
      const Duration(seconds: 2),
    );

    _list = [
      ..._list,
    ];
    state = AsyncValue.data(_list);
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    _repository = ref.read(videosRepo);
    final result = await _repository.fetchVideo();
    final newList = result.docs
        .map(
          (doc) => VideoModel.fromJson(
            doc.data(),
          ),
        )
        .toList();
    _list = newList;
    return _list;
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
