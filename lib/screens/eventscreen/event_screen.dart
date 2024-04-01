import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/event_controller.dart';
import '../../models/Event.dart';

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
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
        title: Text('Event List'),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshEvents,
        child: FutureBuilder<List<Event>>(
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
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Event event = snapshot.data![index];
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(event.eventName ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(event.locationOfEvent ?? ''),
                          Text('Date: ${event.date ?? ''}'),
                          Text('End Date: ${event.endTime ?? ''}'),
                          Text('End Date: ${event.startTime ?? ''}'),
                          Text('Description: ${event.description ?? ''}'),
                          Text('Event Picture: ${event.eventPicture ?? ''}'),
                          Image.network(event.eventPicture!,width: 300,)
                        ],
                      ),
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
      ),
    );
  }
}
