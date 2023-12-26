import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utilities.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent,) {
    final isDark = isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      ),
      child: TabBar(
        labelPadding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        splashFactory: NoSplash.splashFactory,
        indicatorColor: isDark ? null : Colors.black,
        labelColor: isDark ? null : Colors.black,
        tabs: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Icon(Icons.grid_4x4_rounded),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: FaIcon(FontAwesomeIcons.heart),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 47;

  @override
  // TODO: implement minExtent
  double get minExtent => 47;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
