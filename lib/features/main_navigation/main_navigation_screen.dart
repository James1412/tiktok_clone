import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/features/main_navigation/stf_screen.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const StfScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const StfScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const StfScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const StfScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavTab(
              isSelected: _selectedIndex == 0,
              text: "Home",
              selectedIcon: FontAwesomeIcons.house,
              icon: FontAwesomeIcons.house,
              onTap: () => _onTap(0),
            ),
            NavTab(
              isSelected: _selectedIndex == 1,
              text: "Discover",
              selectedIcon: FontAwesomeIcons.solidCompass,
              icon: FontAwesomeIcons.compass,
              onTap: () => _onTap(1),
            ),
            NavTab(
              isSelected: _selectedIndex == 3,
              text: "Inbox",
              selectedIcon: FontAwesomeIcons.solidMessage,
              icon: FontAwesomeIcons.message,
              onTap: () => _onTap(3),
            ),
            NavTab(
              isSelected: _selectedIndex == 4,
              text: "Profile",
              selectedIcon: FontAwesomeIcons.solidUser,
              icon: FontAwesomeIcons.user,
              onTap: () => _onTap(4),
            ),
          ],
        ),
      ),
    );
  }
}
