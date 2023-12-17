import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utilities.dart';

class DiscoverSearchTab extends StatefulWidget {
  final TextEditingController controller;
  final Function onChanged;
  final Function onSubmitted;
  const DiscoverSearchTab(
      {super.key,
      required this.controller,
      required this.onChanged,
      required this.onSubmitted});

  @override
  State<DiscoverSearchTab> createState() => _DiscoverSearchTabState();
}

class _DiscoverSearchTabState extends State<DiscoverSearchTab> {
  bool isXmark = false;
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.size40,
      child: TextField(
        onTapOutside: (value) {
          setState(() {
            isXmark = false;
          });
        },
        onTap: () {
          setState(() {
            isXmark = true;
          });
        },
        controller: widget.controller,
        onChanged: widget.onChanged(),
        onSubmitted: widget.onSubmitted(),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Sizes.size10,
              ),
              borderSide: BorderSide.none,
            ),
            filled: true,
            contentPadding: const EdgeInsets.only(),
            fillColor:
                isDarkMode(context) ? Colors.black : Colors.grey.shade200,
            hintText: "Search",
            prefixIcon: const Align(
              widthFactor: 1,
              heightFactor: 1,
              child: FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                size: Sizes.size16 + Sizes.size2,
              ),
            ),
            suffixIcon: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isXmark ? 1 : 0,
              child: Align(
                widthFactor: 1,
                heightFactor: 1,
                child: GestureDetector(
                  onTap: () {
                    widget.controller.clear();
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.solidCircleXmark,
                    size: Sizes.size16 + Sizes.size2,
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
