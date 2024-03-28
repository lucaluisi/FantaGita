import 'package:flutter/material.dart';

class CustomContainerCard extends StatelessWidget {
  final Color? color;
  final Color textColor;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Widget child;

  const CustomContainerCard({
    super.key,
    this.color = const Color(0xff943846),
    this.textColor = Colors.white,
    this.padding = const EdgeInsets.all(20),
    this.margin = const EdgeInsets.all(0),
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ClipPath(
        clipper: const ShapeBorderClipper(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(70),
            ),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: padding,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
          ),
          child: child,
        ),
      ),
    );
  }
}
