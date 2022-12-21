import 'package:flutter/material.dart';
import 'package:homework_5/user_database_manager.dart';
import 'package:homework_5/login_page.dart';
import 'package:homework_5/registration_page.dart';
import 'package:homework_5/home_page.dart';
import 'package:homework_5/events_database_manager.dart';
import 'package:homework_5/events_page.dart';
import 'package:homework_5/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userDatabaseManager = UserDatabaseManager();
  await userDatabaseManager.database;
  final eventsDatabaseManager = EventsDatabaseManager();
  await eventsDatabaseManager.database;
  runApp(MyApp(
    userDatabaseManager: userDatabaseManager,
    eventsDatabaseManager: eventsDatabaseManager,
  ));
}

class MyApp extends StatelessWidget {
  final UserDatabaseManager userDatabaseManager;
  final EventsDatabaseManager eventsDatabaseManager;

  const MyApp({
    required this.userDatabaseManager,
    required this.eventsDatabaseManager,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(userDatabaseManager: userDatabaseManager,),
        '/registration': (context) => RegistrationPage(userDatabaseManager: userDatabaseManager, user: const {},),
        '/home': (context) => HomePage(
          userDatabaseManager: userDatabaseManager,
          eventsDatabaseManager: eventsDatabaseManager,
        ),
        '/events': (context) => EventPage(eventsDatabaseManager: eventsDatabaseManager),
        '/profile': (context) => ProfilePage(userDatabaseManager: userDatabaseManager),
      },
    );
  }
}