import 'package:flutter/material.dart';
import 'package:homework_5/user_database_manager.dart';

class LoginPage extends StatefulWidget {
  final UserDatabaseManager userDatabaseManager;

  const LoginPage({super.key, required this.userDatabaseManager});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _turkishIdController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
                  if (_formKey.currentState!.validate()) {
                    final user = await widget.userDatabaseManager.getUser(
                      turkishId: _turkishIdController.text,
                      password: _passwordController.text,
                    );
                    if (user == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Invalid Turkish ID number or password'),
                        ),
                      );
                    } else {
                      Navigator.pushNamed(context, '/home');
                    }
                  }
                },
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registration');
                },
                child: const Text('Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
