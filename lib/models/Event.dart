class Event {
  int? eventId;
  String? eventName;
  String? locationOfEvent;
  String? date;
  String? startTime;
  String? endTime;
  String? description;
  String? eventPicture;

  Event({
    this.eventId,
    this.eventName,
    this.locationOfEvent,
    this.date,
    this.startTime,
    this.endTime,
    this.description,
    this.eventPicture,
  });

  Event.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventName = json['eventName'];
    locationOfEvent = json['locationOfEvent'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    description = json['description'];
    eventPicture = json['eventPicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = this.eventId;
    data['eventName'] = this.eventName;
    data['locationOfEvent'] = this.locationOfEvent;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['description'] = this.description;
    data['eventPicture'] = this.eventPicture;
    return data;
  }
}
