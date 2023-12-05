import 'package:flutter/material.dart';

class VideoTimeLineScreen extends StatefulWidget {
  const VideoTimeLineScreen({super.key});

  @override
  State<VideoTimeLineScreen> createState() => _VideoTimeLineScreenState();
}

class _VideoTimeLineScreenState extends State<VideoTimeLineScreen> {
  int _itemCount = 4;
  final _pageViewController = PageController();

  List<Color> colors = [
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.blue,
  ];

  void _onPageChanged(int page) {
    _pageViewController.animateToPage(
      page,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
    );
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      colors.addAll([
        Colors.green,
        Colors.yellow,
        Colors.red,
        Colors.blue,
      ]);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageViewController,
      onPageChanged: _onPageChanged,
      scrollDirection: Axis.vertical,
      itemCount: _itemCount,
      itemBuilder: (context, index) {
        return Container(
          color: colors[index],
          child: Center(
            child: Text(
              "Screen $index",
              style: const TextStyle(fontSize: 30),
            ),
          ),
        );
      },
    );
  }
}
