// import 'dart:html';
//
// import 'package:get/get.dart';
//
//
//
// import 'package:event_management_app/screens/reusable/product_card.dart';
// import 'package:flutter/material.dart';
//
// import '../../utility/sizes.dart';
//
//
// class TGridLayout extends StatelessWidget {
//   final List<Event> events;
//   const TGridLayout({
//     super.key,
//     //required this.itemCount,
//     this.mainAxisExtent=581,
//     //required this.itemBuilder,
//     required this.events,
//   });
//
//   //final int itemCount;
//   final double? mainAxisExtent;
//   //final Widget? Function(BuildContext, int) itemBuilder;
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       itemCount: events.length,
//       padding: EdgeInsets.zero,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 1,
//         mainAxisSpacing: TSizes.gridViewSpacing,
//         crossAxisSpacing: TSizes.gridViewSpacing,
//         mainAxisExtent: mainAxisExtent,
//       ),
//       itemBuilder: (context, index) => TProductCardVertical(
//         onTap: () => Get.to(() => const EventDetailsScreen()),
//         eventName: events[index].name,
//         eventImageUrl: events[index].imageUrl,
//         eventPrice: events[index].price,
//       ),
//     );
//   }
// }
