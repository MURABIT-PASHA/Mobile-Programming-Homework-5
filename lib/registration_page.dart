import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homework_5/user_database_manager.dart';
import 'package:sqflite/sqflite.dart';

class RegistrationPage extends StatefulWidget {
  final Map<String, dynamic> user;

  const RegistrationPage({super.key, required this.user, required UserDatabaseManager userDatabaseManager});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: _turkishId,
                decoration: const InputDecoration(labelText: 'Turkish ID number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Surname'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your surname';
                  }
                  return null;
                },
                onSaved: (value) => _surname = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
                obscureText: true,
              ),
              CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _dob,
                onDateTimeChanged: (date) {
                  setState(() => _dob = date);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
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
              SwitchListTile(
                value: _hasDriverLicense,
                onChanged: (value) {
                  setState(() {
                    _hasDriverLicense = value;
                  });
                },
                title: const Text('Driver License'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Map<String, dynamic> user = {
                        'turkishId': _turkishId,
                        'name': _name,
                        'surname': _surname,
                        'password': _password,
                        'dob': _dob,
                        'maritalStatus': _maritalStatus,
                        'interests': _interests,
                        'hasDriverLicense': _hasDriverLicense,
                      };
                      if (widget.user.isEmpty) {
                        _addUser(user);
                      } else {
                        _updateUser(user);
                      }
                    }
                  },
                  child: Text(widget.user.isEmpty ? 'Sign Up' : 'Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addUser(Map<String, dynamic> user) async {
    Database db = await openDatabase('users.db');
    await db.insert('users', user);
    _showSnackBar('User added successfully');
  }

  void _updateUser(Map<String, dynamic> user) async {
    Database db = await openDatabase('users.db');
    await db.update(
      'users',
      user,
      where: 'turkishId = ?',
      whereArgs: [user['turkishId']],
    );
    _showSnackBar('User updated successfully');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
