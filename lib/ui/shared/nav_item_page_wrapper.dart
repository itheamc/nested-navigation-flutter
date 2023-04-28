import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_nested_navigation/core/routes/app_routes.dart';
import 'package:multi_nested_navigation/core/routes/routes_state_provider.dart';
import 'package:multi_nested_navigation/ui/shared/a_bottom_navigation.dart';
import 'package:multi_nested_navigation/utils/extension_functions.dart';

class NavItemPageWrapper extends ConsumerStatefulWidget {
  const NavItemPageWrapper({
    super.key,
    required this.child,
    required this.state,
  });

  final Widget child;
  final GoRouterState state;

  @override
  ConsumerState<NavItemPageWrapper> createState() => _NavItemPageWrapperState();
}

class _NavItemPageWrapperState extends ConsumerState<NavItemPageWrapper> {
  /// Function to handle nav item selection
  void _onSelect(NavItem item) {
    final route = ref.read(routeStateProvider);
    final routeNotifier = ref.read(routeStateProvider.notifier);

    if (route != item.path) {
      final globalState = AppRoutes.rootNavigatorKey.currentState;
      final shellState = AppRoutes.shellNavigatorKey.currentState;
      final homeState = AppRoutes.navigatorKeys[NavItem.home]!.currentState;
      routeNotifier.updateRoute(item.path);
      context.go(item.path);

      print("[Global]======> ${globalState?.widget.pages.length}");
      print("[Shell]======> ${shellState?.widget.pages.length}");
      print("[Home]======> ${homeState?.widget.pages.length}");

      if (shellState != null) {
        // shellState.pushNamed(AppRoutes.pathAsName(item.path));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String route = ref.watch(routeStateProvider);
    return WillPopScope(
      onWillPop: () async {
        if (route == AppRoutes.home) {
          return true;
        }

        _onSelect(NavItem.home);
        return false;
      },
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: ABottomNavigation(
          currentNavItem: route.toNavItem ?? NavItem.home,
          onSelect: _onSelect,
        ),
      ),
    );
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

  Key? get navigatorKey => AppRoutes.navigatorKeys[navItem];
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
      return const SizedBox.shrink();
    }
  }
}
