import 'package:event_management_app/screens/reusable/product_text_price.dart';
import 'package:event_management_app/screens/reusable/rounded_images.dart';
import 'package:flutter/material.dart';
import '../../utility/color_constants.dart';
import '../../utility/sizes.dart';
import '../reusable/product_text_title.dart';
import '../reusable/rounded_container.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({
    Key? key,
    //required this.eventPrice,
    this.onTap,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.endDate,
    required this.startTime,
    required this.eventPictureUrl,
  }) : super(key: key);

  //final double eventPrice;
  final VoidCallback? onTap;
  final String title;
  final String subtitle;
  final String date;
  final String endDate;
  final String startTime;
  final String eventPictureUrl;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.darkerGrey.withOpacity(0.1),
              blurRadius: 50,
              spreadRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
          color: AppColors.white,
        ),
        child: Column(
          children: [
            /// Thumbnail, Wishlist Button Discount Tag
            TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: AppColors.light,
              child: TRoundedImage(
                isNetworkImage: true,
                imageUrl: eventPictureUrl,
                applyImageRadius: true,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),

            /// --- Details
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm, right: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TProductTextTitle(
                        title: title,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      TProductTextTitle(title: '05-06-2024'),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TProductTextTitle(
                    title: subtitle,
                  ),
                ],
              ),
            ),
            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Price
                Padding(
                  padding: const EdgeInsets.only(left: TSizes.sm),
                  child: TProductPriceText(price: '400'),
                ),

                /// Add to Cart Button
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(TSizes.cardRadiusMd),
                      bottomRight: Radius.circular(TSizes.productImageRadius),
                    ),
                  ),
                  child: SizedBox(
                    width: TSizes.iconLg * 2.8,
                    height: TSizes.iconLg * 1.2,
                    child: Center(
                      child: Text(
                        'Get Ticket',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .apply(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
