import 'package:flutter/material.dart';
import 'package:homework_5/user_database_manager.dart';
import 'package:homework_5/events_database_manager.dart';
import 'package:homework_5/profile_page.dart';
import 'package:homework_5/events_page.dart';

class HomePage extends StatefulWidget {
  final UserDatabaseManager userDatabaseManager;
  final EventsDatabaseManager eventsDatabaseManager;

  const HomePage({super.key,
    required this.userDatabaseManager,
    required this.eventsDatabaseManager,
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
                    builder: (context) => EventPage(
                      eventsDatabaseManager: widget.eventsDatabaseManager,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                Navigator.popAndPushNamed(context, '/');
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}
