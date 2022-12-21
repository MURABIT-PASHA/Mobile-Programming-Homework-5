import 'package:flutter/material.dart';
import 'package:homework_5/event.dart';

import 'events_database_manager.dart';

class AddEventPage extends StatefulWidget {
  final EventDatabaseManager eventDatabaseManager;

  const AddEventPage({super.key, required this.eventDatabaseManager});

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  final _eventDateController = TextEditingController();
  final _eventIdController = TextEditingController();
  final _eventNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextField(
                  controller: _eventDateController,
                  decoration: const InputDecoration(labelText: 'Event Date'),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _eventDateController.text = value;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please enter your name")));
                    }
                  }),
              TextFormField(
                  controller: _eventIdController,
                  decoration: const InputDecoration(labelText: 'Event ID'),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _eventIdController.text = value;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please enter your event ID")));
                    }
                  }),
              TextFormField(
                  controller: _eventNameController,
                  decoration: const InputDecoration(labelText: 'Event Name'),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _eventDateController.text = value;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please enter your event name")));
                    }
                  }),
              ElevatedButton(
                onPressed: () {
                  if (control()) {
                    // Create an Event object from the entered information
                    Event event = Event(
                      DateTime.parse(_eventDateController.text),
                      int.parse(_eventIdController.text),
                      _eventNameController.text,
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
      ),
    );
  }

  bool control() {
    if (_eventDateController.text == "" ||
        _eventIdController.text == "" ||
        _eventNameController.text == "") {
      return false;
    } else {
      return true;
    }
  }
}
