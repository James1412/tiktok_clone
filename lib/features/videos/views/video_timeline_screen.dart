import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/view_models/timeline_view_model.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_post.dart';

class VideoTimeLineScreen extends ConsumerStatefulWidget {
  const VideoTimeLineScreen({super.key});

  @override
  VideoTimeLineScreenState createState() => VideoTimeLineScreenState();
}

class VideoTimeLineScreenState extends ConsumerState<VideoTimeLineScreen> {
  int _itemCount = 0;
  final _pageViewController = PageController();

  final _scrollDuration = const Duration(milliseconds: 250);
  final _scrollCurve = Curves.linear;

  void _onPageChanged(int page) {
    _pageViewController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
    if (page == _itemCount - 1) {
      ref.read(timelineProvider.notifier).fetchNextPage();
    }
  }

  void _onVideoFinished() {
    return;
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    return ref.read(timelineProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              "Could not load videos: $error",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          data: (videos) {
            _itemCount = videos.length;
            return RefreshIndicator(
              displacement: 50,
              edgeOffset: 20,
              color: Theme.of(context).primaryColor,
              onRefresh: _onRefresh,
              child: PageView.builder(
                controller: _pageViewController,
                onPageChanged: _onPageChanged,
                scrollDirection: Axis.vertical,
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final videoData = videos[index];
                  return VideoPost(
                    onVideoFinished: _onVideoFinished,
                    index: index,
                    videoData: videoData,
                  );
                },
              ),
            );
          },
        );
  }
}
