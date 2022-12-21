import 'package:flutter/material.dart';
import 'package:homework_5/user.dart';
import 'package:homework_5/user_database_manager.dart';
import 'package:homework_5/registration_page.dart';

class ProfilePage extends StatefulWidget {
  final UserDatabaseManager userDatabaseManager;

  const ProfilePage({required this.userDatabaseManager});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    final user = await widget.userDatabaseManager
        .getUser(turkishId: '1111111', password: '111111');
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
          ? Center(
              child: const CircularProgressIndicator(),
            )
          : Column(
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
    );
  }
}
