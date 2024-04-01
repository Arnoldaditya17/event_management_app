import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../utility/color_constants.dart';
import '../../utility/sizes.dart';

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: TSizes.defaultSpace / 2, horizontal: TSizes.defaultSpace),
      decoration: BoxDecoration(
        color:AppColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(TSizes.md),
            backgroundColor: AppColors.black,
            side: const BorderSide(color: AppColors.black),
          ),
          child: const Text('Add to Cart'),
        ),
      ),
    );
  }
}
