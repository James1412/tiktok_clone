import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utilities.dart';

import '../../../constants/gaps.dart';

class NavTab extends StatelessWidget {
  final bool isSelected;
  final String text;
  final IconData icon;
  final IconData selectedIcon;
  final Function onTap;
  final int index;
  const NavTab({
    super.key,
    required this.isSelected,
    required this.text,
    required this.icon,
    required this.onTap,
    required this.selectedIcon,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          color: index == 0 || isDark ? Colors.black : Colors.white,
          child: AnimatedOpacity(
            opacity: isSelected ? 1 : 0.6,
            duration: const Duration(milliseconds: 100),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  isSelected ? selectedIcon : icon,
                  color: index == 0 || isDark ? Colors.white : Colors.black,
                ),
                Gaps.v5,
                Text(
                  text,
                  style: TextStyle(
                    color: index == 0 || isDark ? Colors.white : Colors.black,
                    fontSize: Sizes.size10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
