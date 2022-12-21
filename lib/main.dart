import 'package:flutter/material.dart';
import 'package:homework_5/user_database_manager.dart';
import 'package:homework_5/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userDatabaseManager = UserDatabaseManager();
  await userDatabaseManager.init();
  runApp(MyApp(
    userDatabaseManager: userDatabaseManager,
  ));
}

class MyApp extends StatelessWidget {
  final UserDatabaseManager userDatabaseManager;

  const MyApp({super.key,
    required this.userDatabaseManager,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(userDatabaseManager: userDatabaseManager),
    );

  }
}