import 'package:flutter/material.dart';
import 'package:homework_5/login_page.dart';
import 'package:homework_5/registration_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Homework 5'),
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id : (context) => const LoginPage(),
        RegistrationPage.id : (context) => const RegistrationPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
