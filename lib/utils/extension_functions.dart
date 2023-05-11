import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_nested_navigation/core/routes/app_routes.dart';
import 'package:multi_nested_navigation/ui/shared/a_bottom_navigation.dart';

/// BuildContext Extension functions
extension BuildContextExt on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ThemeData get theme => Theme.of(this);

  double get width => mediaQuery.size.width;

  double get height => mediaQuery.size.height;

  GoRouter get goRouter => GoRouter.of(this);

  void goFromHome(String location, {Object? extra}) =>
      go(location, extra: extra);

  void goFromHomeNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) =>
      goNamed(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );
}

/// Extension on NavItem
extension NavItemExt on NavItem {
  BottomNavigationBarItem get toBottomNavigationBarItem {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Icon(activeIcon),
      label: label,
      tooltip: label,
    );
  }
}

/// Extension functions on String
extension StringExt on String {
  NavItem? get toNavItem {
    final navItems = {
      AppRoutes.home: NavItem.home,
      AppRoutes.map: NavItem.map,
      AppRoutes.saved: NavItem.saved,
      AppRoutes.tasks: NavItem.tasks,
    };

    return navItems[this];
  }
}
