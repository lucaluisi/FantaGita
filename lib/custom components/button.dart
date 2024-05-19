import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Border? border;
  final EdgeInsets padding;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color = const Color(0xff943846),
    this.border = const Border(),
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
            child: child
          ),
        ),
      ),
    );
  }
}
