import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:event_management_app/screens/reusable/rounded_images.dart';
import 'package:get/get.dart';
import '../../utility/color_constants.dart';
import '../../utility/sizes.dart';
import 'circular_container.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key, required this.banners,
  });

  final List<String> banners;


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(viewportFraction: 1, onPageChanged: (index,_) => controller.updatePageIndicator(index)),
          items: banners.map((url) => TRoundedImage(imageUrl: url, fit: BoxFit.fill,),).toList(),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Obx(
              () => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < 1; i++) TCircularContainer(width: 20, height: 4, margin: const EdgeInsets.only(right: 10), backgroundColor: controller.carousalCurrentIndex.value == i ? AppColors.primary : AppColors.grey,),
            ],
          ),
        ),
      ],
    );
  }
}

class HomeController extends GetxController {
  static HomeController get instances => Get.find();

  final carousalCurrentIndex = 0.obs;

  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }
}