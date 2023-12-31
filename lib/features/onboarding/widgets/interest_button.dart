// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tiktok_clone/utilities.dart';

import '../../../constants/sizes.dart';

class InterestButton extends StatefulWidget {
  Function onItemTap;
  InterestButton({
    super.key,
    required this.interest,
    required this.onItemTap,
  });

  final interest;

  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  bool _isSelected = false;

  void _onTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
    widget.onItemTap(widget.interest);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size12,
          horizontal: Sizes.size16,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
          ),
          color: _isSelected
              ? Theme.of(context).primaryColor
              : isDarkMode(context)
                  ? Colors.grey.shade500
                  : Colors.white,
          borderRadius: BorderRadius.circular(Sizes.size32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Text(
          widget.interest,
          style: TextStyle(
            color: _isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
