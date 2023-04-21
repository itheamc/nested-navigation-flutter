import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_nested_navigation/core/routes/app_routes.dart';
import 'package:multi_nested_navigation/ui/shared/material3_bottom_navigation.dart';

class MainPage extends StatefulWidget {
  final Widget? child;
  final void Function(int i)? navigate;

  const MainPage({
    super.key,
    this.child,
    this.navigate,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.child,
        bottomNavigationBar: Material3BottomNavigation(
          onTap: (i) {
            setState(() {
              _activeIndex = i;
            });
            widget.navigate?.call(i);
          },
          currentIndex: _activeIndex,
          items: [
            Material3NavigationItem(
              label: "Home",
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
            ),
            Material3NavigationItem(
              label: "Map",
              icon: Icons.map_outlined,
              activeIcon: Icons.map,
            ),
            Material3NavigationItem(
              label: "Saved",
              icon: Icons.task_outlined,
              activeIcon: Icons.task,
            ),
            Material3NavigationItem(
              label: "Task",
              icon: Icons.task_alt_outlined,
              activeIcon: Icons.task_alt,
            ),
          ],
        ));
  }
}
