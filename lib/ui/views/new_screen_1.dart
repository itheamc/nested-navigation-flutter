import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routes/app_routes.dart';

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
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("Title ${index + 1}"),
            onTap: () {
              context.pushNamed(AppRoutes.pathAsName(AppRoutes.newScreen2));
            },
          );
        },
      ),
    );
  }
}
