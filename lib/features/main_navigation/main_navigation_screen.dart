import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final screens = [
    const Center(
      child: Text("Home"),
    ),
    const Center(
      child: Text("Search"),
    ),
    const Center(
      child: Text("Home"),
    ),
    const Center(
      child: Text("Search"),
    ),
    const Center(
      child: Text("Home"),
    ),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            tooltip: "Go Home",
            icon: FaIcon(FontAwesomeIcons.house),
            backgroundColor: Colors.amber,
          ),
          BottomNavigationBarItem(
            label: "Search",
            tooltip: "Search items",
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            label: "Home",
            tooltip: "Go Home",
            icon: FaIcon(FontAwesomeIcons.house),
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            label: "Search",
            tooltip: "Search items",
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            label: "Home",
            tooltip: "Go Home",
            icon: FaIcon(FontAwesomeIcons.house),
            backgroundColor: Colors.deepPurple,
          ),
        ],
      ),
    );
  }
}
