import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/views/video_preview_screen.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _isSelfieMode = false;
  late final double maxZoom;
  late double _currentZoom;
  // NO CAMERA ON IOS SIMULATOR
  late final bool _noCamera = kDebugMode && Platform.isIOS;

  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );
  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
    lowerBound: 0.0,
    upperBound: 1.0,
  );
  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationController);
  late FlashMode _flashMode;
  late CameraController _cameraController;

  Future<void> initCamera() async {
    // DOES NOT WORK ON IOS SIMULATORS. IT WILL RAISE AN ERROR
    // USE AN ANDROID SIMULATOR OR A REAL DEVICE
    List<CameraDescription> cameras = await availableCameras();
    if (cameras.isEmpty) {
      return;
    }
    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.high,
    );
    await _cameraController.initialize();
    await _cameraController.prepareForVideoRecording();
    maxZoom = await _cameraController.getMaxZoomLevel();
    _currentZoom = 1.0;
    _flashMode = _cameraController.value.flashMode;
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;
    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      initPermissions();
    } else {
      setState(() {
        _hasPermission = true;
      });
    }
    WidgetsBinding.instance.addObserver(this);
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  @override
  Future didChangeAppLifecycleState(AppLifecycleState state) async {
    if (!_hasPermission) return;
    if (!_cameraController.value.isInitialized) return;
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      if (!_cameraController.value.isInitialized) {
        return;
      }
      _cameraController.initialize();
    } else if (state == AppLifecycleState.resumed) {
      await initCamera();
      setState(() {});
    }
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    if (_isSelfieMode) return;
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> _startRecording() async {
    if (_cameraController.value.isRecordingVideo) {
      return;
    }
    await _cameraController.startVideoRecording();
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) {
      return;
    }
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();
    final video = await _cameraController.stopVideoRecording();
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: false,
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_noCamera) {
      return;
    }
    _cameraController.dispose();
    _buttonAnimationController.dispose();
    _progressAnimationController.dispose();
    super.dispose();
  }

  Future<void> _onPickVideoPressed() async {
    final XFile? video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (video == null) {
      return;
    }
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  void _onCameraZoom(LongPressMoveUpdateDetails detail) async {
    if (detail.offsetFromOrigin.direction > 0) {
      if (_currentZoom - 0.2 >= 1.0) {
        await _cameraController.setZoomLevel(_currentZoom - 0.2);
        setState(() {
          _currentZoom -= 0.2;
        });
      }
    } else if (detail.offsetFromOrigin.direction < 0) {
      if (_currentZoom + 0.2 <= maxZoom) {
        await _cameraController.setZoomLevel(_currentZoom + 0.2);
        setState(() {
          _currentZoom += 0.2;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasPermission
            ? const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Initializing...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.v20,
                  CircularProgressIndicator.adaptive(),
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  if (!_noCamera && _cameraController.value.isInitialized)
                    CameraPreview(
                      _cameraController,
                    ),
                  if (!_noCamera)
                    Positioned(
                      top: Sizes.size36,
                      right: Sizes.size12,
                      child: Column(
                        children: [
                          IconButton(
                            color: Colors.white,
                            onPressed: _toggleSelfieMode,
                            icon: const Icon(
                              Icons.cameraswitch,
                            ),
                          ),
                          Gaps.v10,
                          IconButton(
                            color: _flashMode == FlashMode.off
                                ? Colors.amber.shade300
                                : Colors.white,
                            onPressed: () => _setFlashMode(FlashMode.off),
                            icon: const Icon(
                              Icons.flash_off_rounded,
                            ),
                          ),
                          IconButton(
                            color: _flashMode == FlashMode.always
                                ? Colors.amber.shade300
                                : Colors.white,
                            onPressed: () => _setFlashMode(FlashMode.always),
                            icon: const Icon(
                              Icons.flash_on_rounded,
                            ),
                          ),
                          IconButton(
                            color: _flashMode == FlashMode.auto
                                ? Colors.amber.shade300
                                : Colors.white,
                            onPressed: () => _setFlashMode(FlashMode.auto),
                            icon: const Icon(
                              Icons.flash_auto_rounded,
                            ),
                          ),
                          IconButton(
                            color: _flashMode == FlashMode.torch
                                ? Colors.amber.shade300
                                : Colors.white,
                            onPressed: () => _setFlashMode(FlashMode.torch),
                            icon: const Icon(
                              Icons.flashlight_on_rounded,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Positioned(
                    bottom: Sizes.size96,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTapDown: (detail) => _startRecording(),
                          onTapUp: (detail) => _stopRecording(),
                          onLongPressEnd: (detail) => _stopRecording(),
                          onLongPressMoveUpdate: _onCameraZoom,
                          child: ScaleTransition(
                            scale: _buttonAnimation,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: Sizes.size80,
                                  height: Sizes.size80,
                                  child: CircularProgressIndicator(
                                    color: Colors.red,
                                    strokeWidth: Sizes.size6,
                                    value: _progressAnimationController.value,
                                  ),
                                ),
                                Container(
                                  width: Sizes.size60,
                                  height: Sizes.size60,
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade500,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: _onPickVideoPressed,
                              icon: const FaIcon(
                                FontAwesomeIcons.image,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
