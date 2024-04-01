import 'package:flutter/cupertino.dart';

import '../../utility/color_constants.dart';
import '../../utility/sizes.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer(
      {super.key,
        this.width,
        this.height,
        this.radius = TSizes.cardRadiusLg,
        this.child,
        this.showBorder = false,
        this.backgroundColor = AppColors.white,
        this.borderColor = AppColors.borderPrimary,
        this.padding,
        this.margin});

  final double? width, height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color backgroundColor, borderColor;
  final EdgeInsetsGeometry? padding, margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
