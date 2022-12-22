import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homework_5/models/event.dart';
import 'dbms/events_database_manager.dart';

class AddEventPage extends StatefulWidget {
  final EventDatabaseManager eventDatabaseManager;

  const AddEventPage({super.key, required this.eventDatabaseManager});

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  late DateTime _dateOfEvent = DateTime.now();
  late int _eventId = 0;
  late String _eventName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width - 40,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _dateOfEvent,
                onDateTimeChanged: (date) {
                  setState(() => _dateOfEvent = date);
                },
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 40,
              child: TextFormField(
                keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Event ID'),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _eventId = int.parse(value);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please enter your event ID")));
                    }
                  }),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 40,
              child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Event Name'),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _eventName = value;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please enter your event name")));
                    }
                  }),
            ),
            ElevatedButton(
              onPressed: () {
                if (control()) {
                  // Create an Event object from the entered information
                  Event event = Event(
                    _dateOfEvent,
                    _eventId,
                    _eventName,
                  );

                  // Add the event to the database
                  widget.eventDatabaseManager.addEvent(event);

                  // Go back to the previous page
                  Navigator.pop(context);
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all blanks")));
                }
              },
              child: const Text('Add Event'),
            ),
          ],
        ),
      ),
    );
  }

  bool control() {
    if (_eventId == 0 ||
        _eventName == "") {
      return false;
    } else {
      return true;
    }
  }
}
