import 'package:flutter/material.dart';
import 'package:homework_5/registration_page.dart';
import 'package:homework_5/user_manager.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  static String id = "login_id";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    String username = "";
    String password = "";
    Color activeColor = const Color(0xFF000000);
    Color nonactiveColor = const Color(0xFFADADAD);
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "LOGIN",
          style:
              TextStyle(fontFamily: "Poppins", fontSize: 70, color: activeColor),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: [
            Text(
              "Username",
              style: TextStyle(
                  fontFamily: "Poppins", fontSize: 30, color: activeColor),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 20,
              height: 40,
              child: TextField(
                controller: usernameController,
                onChanged: (value) {
                  username = value;
                },
                decoration: InputDecoration(
                  hintText: "Type your username",
                  hintStyle: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 25,
                      color: nonactiveColor),
                  prefix: Icon(
                    Icons.person,
                    color: nonactiveColor,
                  ),
                ),
              ),
            ),
            Text(
              "Password",
              style: TextStyle(
                  fontFamily: "Poppins", fontSize: 30, color: activeColor),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 20,
              height: 40,
              child: TextField(
                controller: passwordController,
                onChanged: (value) {
                  password = value;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Type your password",
                  hintStyle: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 25,
                      color: nonactiveColor),
                  prefix: Icon(
                    Icons.lock,
                    color: nonactiveColor,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                usernameController.text = "";
                passwordController.text = "";
                usernameController.value = const TextEditingValue(text: "");
                passwordController.value = const TextEditingValue(text: "");
                UserManager userManager = UserManager();
                List<String> users = await userManager.readUsers();
                for (String user in users){
                  print(user);
                }
                if(await userManager.controlUser(username, password)){
                  String name = await userManager.getUserName(username, password);
                  setState(() {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>HomePage(title: name)), (route) => false);
                  });
                }
              },
              child: Container(
                  margin: const EdgeInsets.all(50),
                  alignment: Alignment.center,
                  height: 50,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                          colors: [Color(0xFF65D5E1), Color(0xFFE73EF9)])),
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 30,
                        color: Colors.white),
                  )),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RegistrationPage.id, (route) => false);
                },
                child: const Text(
                  "You don't have an account? Sign Up",
                  style: TextStyle(fontFamily: "Poppins", color: Colors.indigo),
                ))
          ],
        ),
      ),
    );
  }
}
