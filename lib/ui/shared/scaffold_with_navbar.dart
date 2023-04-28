import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_nested_navigation/utils/extension_functions.dart';

import '../../core/routes/app_routes.dart';
import 'a_bottom_navigation.dart';

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends StatefulWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.currentNavigator,
    required this.currentRouterState,
    required this.tabs,
    required this.routes,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigator for the currently active tab
  final Navigator currentNavigator;

  /// The pages for the current route
  List<Page<dynamic>> get pagesForCurrentRoute => currentNavigator.pages;

  /// The current router state
  final GoRouterState currentRouterState;

  /// The tabs
  final List<NavItem> tabs;

  // The routes
  final List<RouteBase> routes;

  @override
  State<StatefulWidget> createState() => ScaffoldWithNavBarState();
}

/// State for ScaffoldWithNavBar
class ScaffoldWithNavBarState extends State<ScaffoldWithNavBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  List<_NavBarNavigator> get _tabs => widget.tabs.map((NavItem e) => _NavBarNavigator(e)).toList();

  //
  int _locationToTabIndex(String location) {
    final int index = _tabs.indexWhere(
        (_NavBarNavigator t) => location.startsWith(t.rootRoutePath));
    return index < 0 ? 0 : index;
  }

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant ScaffoldWithNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateForCurrentTab();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateForCurrentTab();
  }

  void _updateForCurrentTab() {
    final int previousIndex = _currentIndex;
    final location = GoRouter.of(context).location;
    _currentIndex = _locationToTabIndex(location);

    final _NavBarNavigator tabNav = _tabs[_currentIndex];
    tabNav.pages = widget.pagesForCurrentRoute;
    tabNav.lastLocation = location;

    if (previousIndex != _currentIndex) {
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      bottomNavigationBar: BottomNavigationBar(
        items: _tabs
            .map((_NavBarNavigator e) => e.navItem.toBottomNavigationBarItem)
            .toList(),
        currentIndex: _currentIndex,
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return FadeTransition(
        opacity: _animationController,
        child: IndexedStack(
            index: _currentIndex,
            children: _tabs
                .map((_NavBarNavigator tab) => tab.buildNavigator(context))
                .toList()));
  }

  void _onItemTapped(int index, BuildContext context) {
    GoRouter.of(context).go(_tabs[index].currentLocation);
  }
}

/// Class representing a tab along with its navigation logic
class _NavBarNavigator {
  _NavBarNavigator(this.navItem);

  final NavItem navItem;

  String? lastLocation;

  String get currentLocation =>
      lastLocation != null ? lastLocation! : rootRoutePath;

  String get rootRoutePath => navItem.path;

  GlobalKey<NavigatorState>? get navigatorKey => AppRoutes.navigatorKeys[navItem];
  List<Page<dynamic>> pages = <Page<dynamic>>[];

  Widget buildNavigator(BuildContext context) {
    if (pages.isNotEmpty) {
      return Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (Route<dynamic> route, dynamic result) {
          if (pages.length == 1 || !route.didPop(result)) {
            return false;
          }
          GoRouter.of(context).pop();
          return true;
        },
      );
    } else {
      return const Scaffold(
        body: Center(child: Text("Hi"),),
      );
    }
  }
}
