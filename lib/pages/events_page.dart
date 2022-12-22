import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:homework_5/models/event.dart';
import '../dbms/events_database_manager.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  late Timer _timer;
  int _currentIndex = 0;
  List<Event> events = [];
  Future<List> _loadEvents() async {
    EventDatabaseManager eventDatabaseManager = EventDatabaseManager();
    await eventDatabaseManager.init();
    events = await eventDatabaseManager.getAllEvents();
    return events;
  }
  @override
  void initState() {
    super.initState();
    _loadEvents();
    _timer = Timer.periodic(const Duration(milliseconds: 50),(_){
      setState(() {});
    });
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: events.isNotEmpty
            ? Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(top: 50),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width - 10,
                      height: 200,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width - 20,
                            height: 50,
                            child: Text(
                              events[_currentIndex].eventName,
                              style: const TextStyle(fontSize: 24, fontFamily: "Poppins", fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width - 20,
                            height: 50,
                            child: Text(
                              DateFormat.yMMMd()
                                  .format(events[_currentIndex].eventDate),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width - 20,
                            height: 50,
                            child: Text(
                              timeUntil(events[_currentIndex].eventDate),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width - 20,
                            height: 50,
                            child: Slider(
                              value: _currentIndex.toDouble(),
                              min: 0,
                              max: events.length - 1,
                              divisions: events.length - 1,
                              onChanged: (double value) {
                                setState(() {
                                  _currentIndex = value.round();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            )
            : Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
          child: const Center(child: Text("There is no event")),
        ));
  }

  String timeUntil(DateTime eventDate) {
    Duration timeUntilEvent = eventDate.difference(DateTime.now());
    if (timeUntilEvent.inDays >= 365) {
      int years = timeUntilEvent.inDays ~/ 365;
      return '$years years';
    } else if (timeUntilEvent.inDays >= 30) {
      int months = timeUntilEvent.inDays ~/ 30;
      return '$months months';
    } else if (timeUntilEvent.inDays >= 7) {
      int weeks = timeUntilEvent.inDays ~/ 7;
      return '$weeks weeks';
    } else if (timeUntilEvent.inDays > 0) {
      return '${timeUntilEvent.inDays} days';
    } else if (timeUntilEvent.inHours > 0) {
      return '${timeUntilEvent.inHours} hours';
    } else if (timeUntilEvent.inMinutes > 0) {
      return '${timeUntilEvent.inMinutes} minutes';
    } else {
      return '${timeUntilEvent.inSeconds} seconds';
    }
  }
}
