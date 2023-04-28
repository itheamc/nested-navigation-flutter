import 'package:flutter/material.dart';

class NewScreen2 extends StatefulWidget {
  const NewScreen2({Key? key}) : super(key: key);

  @override
  State<NewScreen2> createState() => _NewScreen2State();
}

class _NewScreen2State extends State<NewScreen2> {
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
