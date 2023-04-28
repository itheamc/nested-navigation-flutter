import 'package:flutter/material.dart';

class NewScreen1 extends StatefulWidget {
  const NewScreen1({Key? key}) : super(key: key);

  @override
  State<NewScreen1> createState() => _NewScreen1State();
}

class _NewScreen1State extends State<NewScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Screen 1"),
      ),
      body: const Center(
        child: Text("I am the body of new screen 1"),
      ),
    );
  }
}
