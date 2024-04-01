import 'dart:convert';
import 'package:event_management_app/models/Event.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';

class EventController {
  static Future<List<Event>> fetchEvents() async {
    final response = await http
        .get(
          Constants.getUri(
            'api/events',
          ),
        )
        .timeout(
          Duration(seconds: 15),
        );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Event> events = data.map((item) {
        final int? eventId = item['eventId'];
        final String? eventName = item['eventName'];
        final String? locationOfEvent = item['locationOfEvent'];
        final String? date = item['date'];
        final String? startTime = item['startTime'];
        final String? endTime = item['endTime'];
        final String? description = item['description'];
        final String? eventPicture = item['eventPicture'];
        return Event(
          eventId: eventId,
          eventName: eventName,
          locationOfEvent: locationOfEvent,
          date: date,
          startTime: startTime,
          endTime: endTime,
          description: description,
          eventPicture: eventPicture,
        );
      }).toList();
      return events;
    } else {
      throw Exception('Failed to load events');
    }
  }
}
