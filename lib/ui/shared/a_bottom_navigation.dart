import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_nested_navigation/core/routes/app_routes.dart';
import 'package:multi_nested_navigation/utils/extension_functions.dart';

class ABottomNavigation extends StatelessWidget {
  const ABottomNavigation({
    super.key,
    required this.navItems,
    required this.currentNavItem,
    required this.onSelect,
  });

  final List<NavItem> navItems;
  final NavItem currentNavItem;
  final void Function(int index, NavItem item) onSelect;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBarTheme(
      data: context.theme.bottomNavigationBarTheme.copyWith(
        type: BottomNavigationBarType.shifting
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: navItems
            .map(
              (item) => _buildItem(item),
            )
            .toList(),
        onTap: (index) => onSelect(
          index,
          navItems[index],
        ),
        currentIndex: currentNavItem.index,
      ),
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

  void go(BuildContext context, String location, {Object? extra}) {
    final loc = location.startsWith("/") ? '$path$location' : '$path/$location';

    context.go(
      loc,
      extra: extra,
    );
  }

  void goNamed(
    BuildContext context,
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) =>
      context.goNamed(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );

  void push(BuildContext context, String location, {Object? extra}) {
    final loc = location.startsWith("/") ? '$path$location' : '$path/$location';

    context.push(
      loc,
      extra: extra,
    );
  }

  void pushNamed(
    BuildContext context,
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) =>
      context.pushNamed(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );

  void pushReplacement(BuildContext context, String location, {Object? extra}) {
    final loc = location.startsWith("/") ? '$path$location' : '$path/$location';

    context.pushReplacement(
      loc,
      extra: extra,
    );
  }

  void pushReplacementNamed(
    BuildContext context,
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) =>
      context.pushReplacementNamed(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );
}
