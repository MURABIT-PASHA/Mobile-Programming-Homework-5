import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: MediaQuery.of(context).size.width - 100,
        child: Container(
          height: MediaQuery.of(context).size.height, 
          width: MediaQuery.of(context).size.width - 120,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(onPressed: (){}, icon: Icon(Icons.person, color: Colors.white,),
              label: const Text("Profilim", style: TextStyle(fontSize: 15, fontFamily: "Poppins", color: Colors.white),),
              ),
              TextButton.icon(onPressed: (){}, icon: Icon(Icons.event,  color: Colors.white,),
                label: const Text("Etkinliklerim", style: TextStyle(fontSize: 15, fontFamily: "Poppins", color: Colors.white),),
              ),
              TextButton.icon(onPressed: (){}, icon: Icon(Icons.logout,  color: Colors.white,),
                label: const Text("Çıkış Yap", style: TextStyle(fontSize: 15, fontFamily: "Poppins", color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(),
    );
  }
}
