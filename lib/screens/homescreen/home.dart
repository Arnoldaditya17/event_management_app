

import 'package:event_management_app/utility/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../controllers/event_controller.dart';
import '../../models/Event.dart';

import '../../utility/sizes.dart';
import '../reusable/product_card.dart';
import '../reusable/promo_slider.dart';
import '../reusable/section_heading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<List<Event>>? _events;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _events = EventController.fetchEvents();
  }

  Future<void> _refreshEvents() async {
    setState(() {
      _events = EventController.fetchEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: Colors.white),
            ),
            Text(
              'Your Name',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .apply(color: Colors.white),
            ),
          ],
        ),
        elevation: 10,
        toolbarHeight: 80,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshEvents,
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Body
              const Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: TPromoSlider(
                  banners: ['assets/icon/fiestaBanner.png'],
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// --- Heading
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TSectionHeading(
                      title: 'Popular Products',
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    FutureBuilder<List<Event>>(
                      future: _events,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: Lottie.asset(
                              'assets/loader/loaderLottie.json', // Replace with your Lottie file path
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemExtent: 450,
                            itemBuilder: (context, index) {
                              Event event = snapshot.data![index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: TSizes.sm, horizontal: TSizes.xs),
                                child: TProductCardVertical(
                                  title: event.eventName ?? '',
                                  subtitle: event.locationOfEvent ?? '',
                                  date: event.date ?? '',
                                  endDate: event.endTime ?? '',
                                  startTime: event.startTime ?? '',
                                  eventPictureUrl: event.eventPicture ?? '',
                                  onTap: () {
                                    // Handle tap on event
                                  },
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),

                    /// -- Popular Products
                    // TGridLayout(
                    //   itemCount: 2,
                    //   itemBuilder: (index, _) => const TProductCardVertical(),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
