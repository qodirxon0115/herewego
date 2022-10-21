import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("HOME"),
      ),
      body: Center(
        child: Container(
          height: 35,
          width: 65,
          color: Colors.teal,
          child: TextButton(
            onPressed: (){},
            child: const Text(
              "Logout",style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold), ),
          ),
        )
      ),
    );
  }
}
