import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String icon;
  final double iconHeight;
  final Color? color;
  final VoidCallback onPressed;
  final EdgeInsets padding;

  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.iconHeight = 50.0,
    this.color = const Color(0xff943846),
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const ShapeBorderClipper(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Image.asset(icon, height: iconHeight),
          ),
        ),
      ),
    );
  }
}
