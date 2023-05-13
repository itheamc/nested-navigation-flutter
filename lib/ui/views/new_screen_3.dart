import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routes/app_routes.dart';

class NewScreen3 extends StatefulWidget {
  const NewScreen3({Key? key}) : super(key: key);

  @override
  State<NewScreen3> createState() => _NewScreen3State();
}

class _NewScreen3State extends State<NewScreen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Screen 3"),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("Screen 3 Item ${index + 1}"),
          );
        },
      ),
    );
  }
}
