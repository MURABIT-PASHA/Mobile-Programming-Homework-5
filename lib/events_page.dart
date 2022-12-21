import 'package:flutter/material.dart';
import 'package:homework_5/event.dart';
import 'package:homework_5/events_database_manager.dart';
import 'package:intl/intl.dart';

class EventPage extends StatefulWidget {
  final EventsDatabaseManager eventsDatabaseManager;

  const EventPage({super.key,
    required this.eventsDatabaseManager,
  });

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late List<Event> _events;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  void _loadEvents() async {
    final events = await widget.eventsDatabaseManager.getEvents();
    setState(() {
      _events = events.cast<Event>();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_events.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final event = _events[_currentIndex];
    final dateFormat = DateFormat.yMMMd();
    final timeFormat = DateFormat.jm();
    final timeLeft = event.date.difference(DateTime.now()).inDays;
    /*${timeFormat.format(event.time)*/
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: Column(children: [
        Expanded(
          child: Center(
            child: Text(
              event.name,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              '${dateFormat.format(event.date)}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Time left: $timeLeft days',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.navigate_before),
              onPressed: _currentIndex > 0
                  ? () {
                      setState(() {
                        _currentIndex--;
                      });
                    }
                  : null,
            ),
            IconButton(
              icon: const Icon(Icons.navigate_next),
              onPressed: _currentIndex < _events.length - 1
                  ? () {
                      setState(() {
                        _currentIndex++;
                      });
                    }
                  : null,
            ),
          ],
        ),
      ]),
    );
  }
}
