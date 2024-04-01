import 'package:event_management_app/screens/reusable/product_text_price.dart';
import 'package:event_management_app/screens/reusable/product_text_title.dart';
import 'package:event_management_app/screens/reusable/rounded_container.dart';
import 'package:flutter/material.dart';
import '../../utility/color_constants.dart';
import '../../utility/sizes.dart';
import 'circular_image.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price and Sale Price
        Row(
          children: [
            /// Sale Tag
            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: AppColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text(
                '25%',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .apply(color: AppColors.black),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),

            /// Price
            Text('₹500',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough)),
            const SizedBox(width: TSizes.spaceBtwItems),
            const TProductPriceText(
              price: '450',
              isLarge: true,
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Title
        const TProductTextTitle(title: 'Green Nike Sports Shoes'),
        const SizedBox(width: TSizes.spaceBtwItems / 1.5),
      ],
    );
  }
}
