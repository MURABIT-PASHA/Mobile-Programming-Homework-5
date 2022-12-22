import 'package:flutter/material.dart';
import 'package:homework_5/pages/home_page.dart';
import 'package:homework_5/pages/registration_page.dart';
import 'package:homework_5/dbms/user_database_manager.dart';

class LoginPage extends StatefulWidget {
  final UserDatabaseManager userDatabaseManager;
  const LoginPage({super.key, required this.userDatabaseManager});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _turkishIdController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            TextFormField(
              controller: _turkishIdController,
              decoration: const InputDecoration(
                labelText: 'Turkish ID Number',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a Turkish ID number';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final user = await widget.userDatabaseManager.getUser(
                  turkishId: _turkishIdController.text,
                  password: _passwordController.text,
                );
                if (user == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid Turkish ID number or password'),
                    ),
                  );
                } else {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => HomePage(
                              userDatabaseManager: widget.userDatabaseManager,
                              userID: _turkishIdController.text,
                              userPassword: _passwordController.text,
                            )));
                  });
                }
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>RegistrationPage(user: {}, userDatabaseManager: widget.userDatabaseManager,)));
              },
              child: const Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
