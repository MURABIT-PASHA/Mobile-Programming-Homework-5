import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Event {
  final int id;
  final String name;
  final DateTime date;
  final TimeOfDay time;

  Event({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': DateFormat('yyyy-MM-dd').format(date),
      'time': time.toString(),
    };
  }

  static Event fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      name: map['name'],
      date: DateFormat('yyyy-MM-dd').parse(map['date']),
      time: TimeOfDay.fromDateTime(
        DateTime.parse(map['time']),
      ),
    );
  }
}
