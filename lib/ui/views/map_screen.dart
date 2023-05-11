
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routes/app_routes.dart';
import '../shared/a_bottom_navigation.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Map"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.pushNamed(AppRoutes.pathAsName(AppRoutes.newScreen2));
          },
          child: const Text("New Screen 2"),
        ),
      ),
    );
  }
}
