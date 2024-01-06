import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  const VideoPost({
    super.key,
    required this.videoData,
    required this.onVideoFinished,
    required this.index,
  });
  final int index;
  final Function onVideoFinished;
  final VideoModel videoData;

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video1.mp4");
  bool _isPaused = false;
  final Duration _animationDuration = const Duration(milliseconds: 200);
  late final AnimationController _animationController;
  bool _seeMore = false;

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    setState(() {});
    _videoPlayerController.addListener(_onVideoChange);
  }

  void _onPlaybackConfigChanged() {
    if (!mounted) return;
    if (ref.read(playbackConfigProvider).muted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onVisibilityChange(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      if (ref.read(playbackConfigProvider).autoplay) {
        _videoPlayerController.play();
      }
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _togglePause();
    }
  }

  void _togglePause() {
    if (!_isPaused) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _togglePause();
    }
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const VideoCommentsTab(),
    );
    _togglePause();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChange,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _togglePause,
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              color: Colors.white,
              icon: FaIcon(
                ref.watch(playbackConfigProvider).muted
                    ? FontAwesomeIcons.volumeOff
                    : FontAwesomeIcons.volumeHigh,
              ),
              onPressed: _onPlaybackConfigChanged,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Gaps.v52,
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _animationController.value,
                          child: child,
                        );
                      },
                      child: AnimatedOpacity(
                        opacity: _isPaused ? 1 : 0,
                        duration: _animationDuration,
                        child: const FaIcon(
                          FontAwesomeIcons.play,
                          color: Colors.white,
                          size: Sizes.size52,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "@${widget.videoData.creator}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Sizes.size16,
                    ),
                  ),
                  Gaps.v8,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          widget.videoData.description,
                          style: const TextStyle(
                            fontSize: Sizes.size14,
                            color: Colors.white,
                          ),
                          maxLines: _seeMore
                              ? widget.videoData.description.length
                              : null,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (widget.videoData.description.length > 30)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _seeMore = !_seeMore;
                            });
                          },
                          child: Text(
                            _seeMore ? "See less" : "See more",
                            style: const TextStyle(
                              fontSize: Sizes.size12,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 10,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 20,
                  foregroundColor: Colors.white,
                  foregroundImage: const NetworkImage(
                    "https://avatars.githubusercontent.com/u/73318218?v=4",
                  ),
                  child: const Text(
                    "지강",
                  ),
                ),
                Gaps.v32,
                const VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: "2.9M",
                ),
                Gaps.v20,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: const VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: "33K",
                  ),
                ),
                Gaps.v20,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
