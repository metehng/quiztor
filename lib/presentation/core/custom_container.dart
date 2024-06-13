import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    required this.child,
    required this.onTap,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.decoration,
    this.shrinkWrap = false,
  });

  final Widget child;
  final VoidCallback onTap;
  final bool shrinkWrap;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: shrinkWrap ? null : FractionalOffset.center,
        padding: padding,
        margin: margin,
        decoration: decoration,
        child: child,
      ),
    );
  }
}
