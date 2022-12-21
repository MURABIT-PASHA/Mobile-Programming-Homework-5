class Event {
  final DateTime eventDate;
  final int eventId;
  final String eventName;

  Event(this.eventDate, this.eventId, this.eventName);

  Map<String, dynamic> toMap() {
    return {
      'eventDate': eventDate.toIso8601String(),
      'eventId': eventId,
      'eventName': eventName,
    };
  }

  static Event fromMap(Map<String, dynamic> map) {
    return Event(
      DateTime.parse(map['eventDate']),
      map['eventId'],
      map['eventName'],
    );
  }
}
