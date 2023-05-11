import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_nested_navigation/utils/extension_functions.dart';

import '../../../core/routes/app_routes.dart';
import '../../shared/a_bottom_navigation.dart';


class MainWrapperScreen extends StatefulWidget {
  const MainWrapperScreen({
    required this.navigator,
    required this.state,
    required this.items,
    super.key = const ValueKey('MainWrapperScreen'),
  });

  /// The navigator for the currently active tab
  final Navigator navigator;

  /// The pages for the current route
  List<Page<dynamic>> get pages => navigator.pages;

  /// The current router state
  final GoRouterState state;

  /// The list of bottom nav items
  final List<NavItem> items;

  @override
  State<StatefulWidget> createState() => MainWrapperScreenState();
}

class MainWrapperScreenState extends State<MainWrapperScreen> {
  late final List<_NavBarTab> _navBarTabs;

  /// Index of the active bottom nav item
  int _currentIndex = 0;

  /// List for handling backstack
  final _tabsOnStack = List<_NavBarTab>.empty(growable: true);

  /// Helper method to calculate index as per the location
  int _locationToTabIndex(String location) {
    final int index =
    _navBarTabs.indexWhere((tab) => location.startsWith(tab.root));
    return index < 0 ? 0 : index;
  }

  @override
  void initState() {
    super.initState();
    _navBarTabs = widget.items.map((NavItem e) => _NavBarTab(e)).toList();
  }

  @override
  void didUpdateWidget(covariant MainWrapperScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateForCurrentTab();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateForCurrentTab();
  }

  /// Helper function to update the state of current nav bar tab
  void _updateForCurrentTab() {
    final location = context.goRouter.location;
    _currentIndex = _locationToTabIndex(location);

    final _NavBarTab tabNav = _navBarTabs[_currentIndex];
    tabNav.pages = widget.pages;
    tabNav.lastLocation = location;
    _handleAdditionTabsOnStack(tabNav);
  }

  /// Helper method to handle tabs addition on backstack
  void _handleAdditionTabsOnStack(_NavBarTab navigator) {
    if (navigator.root == AppRoutes.home) {
      _tabsOnStack.clear();
      _tabsOnStack.add(navigator);
      return;
    }

    if (_tabsOnStack.isNotEmpty && _tabsOnStack.length > 1) {
      _tabsOnStack.removeLast();
    }
    _tabsOnStack.add(navigator);
  }

  /// Helper method to handle on will pop
  Future<bool> _handleOnWillPop() async {
    if (_tabsOnStack.length > 1) {
      _tabsOnStack.removeLast();
    }

    if (_tabsOnStack.isNotEmpty) {
      final item = _tabsOnStack.last;

      final location = item.currentLocation;
      final root = item.root;

      if (location != root) {
        context.go(location);
        return false;
      }

      if (root == AppRoutes.home) {
        return true;
      }

      context.go(root);
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final navItems = _navBarTabs.map((_NavBarTab e) => e.item).toList();
    return WillPopScope(
      onWillPop: _handleOnWillPop,
      child: Scaffold(
        body: _buildBody(context),
        bottomNavigationBar: ABottomNavigation(
          navItems: navItems,
          currentNavItem: navItems[_currentIndex],
          onSelect: (int i, NavItem item) {
            _handleAdditionTabsOnStack(_navBarTabs[i]);
            context.go(_navBarTabs[i].currentLocation);
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return IndexedStack(
      index: _currentIndex,
      children:
      _navBarTabs.map((_NavBarTab tab) => tab.build(context)).toList(),
    );
  }
}

/// Nav bar Tab class
class _NavBarTab {
  _NavBarTab(this.item);

  /// NavItem that will be associated with this _NavBar
  final NavItem item;

  /// Last known location for this nav bar tab
  String? lastLocation;

  /// Current location for this nav bar tab
  String get currentLocation => lastLocation != null ? lastLocation! : root;

  /// Root location associated with this nav bar tab
  String get root => item.path;

  /// Navigator key for this nav bar tab
  GlobalKey<NavigatorState>? get navigatorKey => AppRoutes.navigatorKeys[item];

  /// List of pages for this tab
  List<Page<dynamic>> pages = <Page<dynamic>>[];

  /// Helper method to build navigator widget if pages is not empty
  /// else just return empty sized box widget
  Widget build(BuildContext context) {
    if (pages.isNotEmpty) {
      return Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (Route<dynamic> route, dynamic result) {
          if (pages.length == 1 || !route.didPop(result)) {
            return false;
          }
          context.goRouter.pop();
          return true;
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
