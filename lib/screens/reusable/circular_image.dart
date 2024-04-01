import 'package:flutter/material.dart';

import '../../utility/color_constants.dart';
import '../../utility/sizes.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({
    Key? key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = TSizes.sm,
  }) : super(key: key);

  final BoxFit fit;
  final dynamic image; // Modified to accept nullable String or ImageProvider
  final bool isNetworkImage;
  final Color? overlayColor, backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: isNetworkImage
            ? Image.network(
          image as String, // Cast to String for network image
          fit: fit,
          color: overlayColor,
        )
            : Image(
          image: image as ImageProvider, // Cast to ImageProvider for asset image
          fit: fit,
          color: overlayColor,
        ),
      ),
    );
  }
}
