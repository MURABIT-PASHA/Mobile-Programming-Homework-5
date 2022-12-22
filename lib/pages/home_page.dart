import 'package:flutter/material.dart';
import 'package:homework_5/add_event.dart';
import 'package:homework_5/dbms/events_database_manager.dart';
import 'package:homework_5/pages/login_page.dart';
import 'package:homework_5/dbms/user_database_manager.dart';
import 'package:homework_5/pages/profile_page.dart';
import 'package:homework_5/pages/events_page.dart';

class HomePage extends StatefulWidget {
  final UserDatabaseManager userDatabaseManager;
  final String userID;
  final String userPassword;

  const HomePage({
    super.key,
    required this.userDatabaseManager,
    required this.userID,
    required this.userPassword,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      userID: widget.userID,
                      userPassword: widget.userPassword,
                      userDatabaseManager: widget.userDatabaseManager,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Events'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EventsPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => LoginPage(
                            userDatabaseManager: widget.userDatabaseManager)),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addEvent();
        },
        child: Icon(Icons.add),
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }

  Future<void> addEvent() async {
    final eventDb = EventDatabaseManager();
    await eventDb.init();
    showDialog(
        context: context,
        builder: (builder) => Dialog(
              child: AddEventPage(eventDatabaseManager: eventDb),
            ));
  }
}
