import 'package:flutter/material.dart';
import 'package:homework_5/dbms/user_database_manager.dart';
import 'package:homework_5/pages/registration_page.dart';

class ProfilePage extends StatefulWidget {
  final String userID;
  final String userPassword;
  final UserDatabaseManager userDatabaseManager;

  const ProfilePage({required this.userID, required this.userPassword, required this.userDatabaseManager});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    final user = await widget.userDatabaseManager
        .getUser(turkishId: widget.userID, password: widget.userPassword);
    setState(() {
      _user = user!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: _user == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Turkish ID: ${_user.turkishId}'),
                  Text('Name: ${_user.name}'),
                  Text('Surname: ${_user.surname}'),
                  Text('Password: ${_user.password}'),
                  Text('Date of Birth: ${_user.dateOfBirth}'),
                  Text('Marital Status: ${_user.maritalStatus}'),
                  Text('Interests: ${_user.interests.join(', ')}'),
                  Text(
                      'Driver\'s License: ${_user.hasDriverLicense ? 'Yes' : 'No'}'),
                  ElevatedButton(
                    child: const Text('Change'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationPage(
                            userDatabaseManager: widget.userDatabaseManager,
                            user: _user.toMap(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
          ),
    );
  }
}
