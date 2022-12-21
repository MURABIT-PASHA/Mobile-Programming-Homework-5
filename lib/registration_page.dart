import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homework_5/login_page.dart';
import 'package:homework_5/user.dart';
import 'package:homework_5/user_database_manager.dart';

class RegistrationPage extends StatefulWidget {
  final Map<String, dynamic> user;

  const RegistrationPage(
      {super.key,
      required this.user,
      required UserDatabaseManager userDatabaseManager});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _turkishId = "";
  String _name = "";
  String _surname = "";
  String _password = "";
  DateTime _dob = DateTime.now();
  String _maritalStatus = "";
  List<String> _interests = [];
  bool _hasDriverLicense = false;

  @override
  void initState() {
    super.initState();
    if (widget.user.isNotEmpty) {
      _turkishId = widget.user['turkishId'];
      _name = widget.user['name'];
      _surname = widget.user['surname'];
      _password = widget.user['password'];
      _dob = widget.user['dob'];
      _maritalStatus = widget.user['maritalStatus'];
      _interests = widget.user['interests'];
      _hasDriverLicense = widget.user['hasDriverLicense'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.user.isEmpty ? 'Sign Up' : 'Edit Profile'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 50,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextField(
                decoration: const InputDecoration(labelText: 'Turkish ID Number'),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _turkishId = value;
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Please enter your ID")));
                  }
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 50,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextField(
                decoration:
                    const InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _name = value;
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Please enter your name")));
                  }
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 50,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextField(
                decoration: const InputDecoration(labelText: 'Surname'),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _surname = value;
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Please enter your surname")));
                  }
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 50,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextField(
                decoration: const InputDecoration(labelText: 'Password'),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _password = value;
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Please enter your password")));
                  }
                },
                obscureText: true,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 150,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _dob,
                onDateTimeChanged: (date) {
                  setState(() => _dob = date);
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 50,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Text('Marital Status'),
                  ),
                  Radio(
                    value: 'single',
                    groupValue: _maritalStatus,
                    onChanged: (value) {
                      setState(() {
                        _maritalStatus = value!;
                      });
                    },
                  ),
                  const Text('Single'),
                  Radio(
                    value: 'married',
                    groupValue: _maritalStatus,
                    onChanged: (value) {
                      setState(() {
                        _maritalStatus = value!;
                      });
                    },
                  ),
                  const Text('Married'),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 200,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Interests'),
                  CheckboxListTile(
                    value: _interests.contains('software'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          _interests.add('software');
                        } else {
                          _interests.remove('software');
                        }
                      });
                    },
                    title: const Text('Software'),
                  ),
                  CheckboxListTile(
                    value: _interests.contains('hardware'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          _interests.add('hardware');
                        } else {
                          _interests.remove('hardware');
                        }
                      });
                    },
                    title: const Text('Hardware'),
                  ),
                  CheckboxListTile(
                    value: _interests.contains('artificial intelligence'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          _interests.add('artificial intelligence');
                        } else {
                          _interests.remove('artificial intelligence');
                        }
                      });
                    },
                    title: const Text('Artificial Intelligence'),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 50,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: SwitchListTile(
                value: _hasDriverLicense,
                onChanged: (value) {
                  setState(() {
                    _hasDriverLicense = value;
                  });
                },
                title: const Text('Driver License'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if(control()) {
                  User user = User(
                    turkishId: _turkishId,
                    name: _name,
                    surname: _surname,
                    password: _password,
                    dateOfBirth: _dob.toIso8601String(),
                    maritalStatus: _maritalStatus,
                    interests: _interests,
                    hasDriverLicense: _hasDriverLicense,
                  );
                  if (widget.user.isEmpty) {
                    _addUser(user);
                  } else {
                    _updateUser(user);
                  }
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all blanks")));
                }
              },
              child: Text(widget.user.isEmpty ? 'Sign Up' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }
  bool control(){
    if (_name == "" || _turkishId == "" || _surname == "" || _password == "" || _maritalStatus == "") {
      return false;
    }
      else{
        return true;
    }
  }

  void _addUser(User user) async {
    UserDatabaseManager userDatabaseManager = UserDatabaseManager();
    await userDatabaseManager.addUser(user);
    _showSnackBar('User added successfully');
    Navigator.push((context), MaterialPageRoute(builder: (builder)=> LoginPage(userDatabaseManager: userDatabaseManager)));
  }

  void _updateUser(User user) async {
    UserDatabaseManager userDatabaseManager = UserDatabaseManager();
    await userDatabaseManager.updateUser(user);
    _showSnackBar('User updated successfully');
    Navigator.push((context), MaterialPageRoute(builder: (builder)=> LoginPage(userDatabaseManager: userDatabaseManager)));
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
