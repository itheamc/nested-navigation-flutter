import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_nested_navigation/ui/views/main_wrapper/widgets/appbar_ui.dart';
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

  /// The current router state
  final GoRouterState state;

  /// The list of bottom nav items
  final List<NavItem> items;

  @override
  State<StatefulWidget> createState() => MainWrapperScreenState();
}

class MainWrapperScreenState extends State<MainWrapperScreen> {
  /// List of navbar tabs
  /// It will be initialize on init
  late final List<_NavBarTab> _navBarTabs;

  /// The pages for the current route
  List<Page<dynamic>> get pages => widget.navigator.pages;

  /// Index of the active bottom nav item
  int _currentIndex = 0;

  /// List for handling backstack
  final _tabsOnStack = List<_NavBarTab>.empty(growable: true);

  /// For appbar visibility
  bool _showAppBar = true;

  /// Is Initial run
  bool _isInitialRun = true;

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
    if (_isInitialRun) {
      _updateForCurrentTab();
    }
  }

  /// Helper function to update the state of current nav bar tab
  void _updateForCurrentTab() {
    final location = context.goRouter.location;
    final newIndex = _locationToTabIndex(location);

    // Is Tab Index Changed
    final bool isIndexChanged = _currentIndex != newIndex;

    // Update tab current index irrespective of index change
    _currentIndex = newIndex;

    final _NavBarTab tabNav = _navBarTabs[_currentIndex];

    // bool to decide whether to update pages or not
    final shouldUpdatePages = _isInitialRun ||
        !isIndexChanged ||
        (isIndexChanged && location == tabNav.item.path);

    if (shouldUpdatePages) {
      // bool to decide whether to remove location from the tab stack or not
      final shouldRemove =
          !isIndexChanged && pages.length < tabNav.pages.length;

      if (shouldRemove) {
        tabNav.removeLastLocationFromStack();
      } else {
        tabNav.updateLocationsOnStack(location);
      }

      tabNav.pages = pages;
      _isInitialRun = false;
    }

    _showAppBar = NavItem.values.map((e) => e.path).contains(location);
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
      final tab = _tabsOnStack.last;

      final location = tab.currentLocation;
      final root = tab.root;

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
        appBar: AppbarUi(
          show: _showAppBar,
        ),
        body: _buildBody(context),
        bottomNavigationBar: ABottomNavigation(
          navItems: navItems,
          currentNavItem: navItems[_currentIndex],
          onSelect: (int i, NavItem item) {
            if (_currentIndex != i) {
              _handleAdditionTabsOnStack(_navBarTabs[i]);
              final loc = _navBarTabs[i].currentLocation;
              context.go(loc);
            }
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

  /// locations on backstack
  final _locationsOnStack = List<String>.empty(growable: true);

  /// Current location for this nav bar tab
  // String get currentLocation => lastLocation != null ? lastLocation! : root;
  String get currentLocation =>
      _locationsOnStack.isNotEmpty ? _locationsOnStack.last : root;

  /// Root location associated with this nav bar tab
  String get root => item.path;

  /// Navigator key for this nav bar tab
  GlobalKey<NavigatorState>? get navigatorKey => AppRoutes.navigatorKeys[item];

  /// List of pages for this tab
  List<Page<dynamic>> pages = <Page<dynamic>>[];

  /// Method to update location on stack list
  void updateLocationsOnStack(String location) {
    if (root == location) {
      _locationsOnStack.clear();
      _locationsOnStack.add(location);
      return;
    }

    final alreadyAdded = _locationsOnStack.any((l) => l == location);

    if (!alreadyAdded) {
      _locationsOnStack.add(location);
    }
  }

  /// Method to remove last item from the location stack
  void removeLastLocationFromStack() {
    if (_locationsOnStack.isNotEmpty) {
      _locationsOnStack.removeLast();
    }
  }

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

          // Popping the page if can pop
          if (context.goRouter.canPop()) {
            context.goRouter.pop();
          }
          return true;
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
