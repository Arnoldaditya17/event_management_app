import 'package:flutter/material.dart';

import '../../utility/color_constants.dart';


class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    super.key,
    this.width,
    this.height,
    this.radius=400,
    this.margin,
    this.padding=0,
    this.child,
    this.backgroundColor=AppColors.white,
  });

  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final Widget? child;
  final EdgeInsets? margin;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}