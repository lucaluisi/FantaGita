import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final double fontSize;
  final Color? color;
  final Color? cursorColor;
  final TextEditingController? controller;
  final EdgeInsets padding;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText = "text",
    this.fontSize = 16.0,
    this.obscureText = false,
    this.color = const Color(0xffeeeeee),
    this.cursorColor = const Color(0xff943846),
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.5),
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
      child: Container(
        decoration: BoxDecoration(
          color: color,
        ),
        child: Padding(
          padding: padding,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            cursorColor: cursorColor,
            style: TextStyle(fontSize: fontSize, color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black)
            ),
          ),
        ),
      ),
    );
  }
}
