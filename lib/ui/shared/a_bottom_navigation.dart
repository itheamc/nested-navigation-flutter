import 'package:flutter/material.dart';
import 'package:multi_nested_navigation/core/routes/app_routes.dart';
import 'package:multi_nested_navigation/utils/extension_functions.dart';

class ABottomNavigation extends StatelessWidget {
  const ABottomNavigation({
    super.key,
    required this.currentNavItem,
    required this.onSelect,
  });

  final NavItem currentNavItem;
  final ValueChanged<NavItem> onSelect;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(NavItem.home),
        _buildItem(NavItem.map),
        _buildItem(NavItem.saved),
        _buildItem(NavItem.tasks),
      ],
      onTap: (index) => onSelect(
        NavItem.values[index],
      ),
      currentIndex: currentNavItem.index,
    );
  }

  BottomNavigationBarItem _buildItem(NavItem item) {
    return item.toBottomNavigationBarItem;
  }
}

/// NavItem Enum for bottom navigation bar
enum NavItem {
  home(
    path: AppRoutes.home,
    label: "Home",
    icon: Icons.home_outlined,
    activeIcon: Icons.home,
  ),
  map(
    path: AppRoutes.map,
    label: "Map",
    icon: Icons.map_outlined,
    activeIcon: Icons.map,
  ),
  saved(
    path: AppRoutes.saved,
    label: "Saved",
    icon: Icons.task_outlined,
    activeIcon: Icons.task,
  ),
  tasks(
    path: AppRoutes.tasks,
    label: "Tasks",
    icon: Icons.task_alt_outlined,
    activeIcon: Icons.task_alt,
  );

  const NavItem({
    required this.path,
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String path;
  final String label;
  final IconData icon;
  final IconData activeIcon;
}
