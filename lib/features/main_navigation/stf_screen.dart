import 'package:flutter/material.dart';

class StfScreen extends StatefulWidget {
  const StfScreen({super.key});

  @override
  State<StfScreen> createState() => _StfScreenState();
}

class _StfScreenState extends State<StfScreen> {
  int _click = 0;
  void _increase() {
    setState(() {
      _click++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("I am built");
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _click.toString(),
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
          TextButton(onPressed: _increase, child: const Text("+")),
        ],
      ),
    );
  }
}
