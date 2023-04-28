import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_nested_navigation/core/routes/app_routes.dart';
import 'package:multi_nested_navigation/ui/shared/a_bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AppRoutes.navigatorKeys[NavItem.home]!.currentState?.context.push(AppRoutes.newScreen1);
          },
          child: Text("New Screen"),
        ),
      ),
    );
  }
}
