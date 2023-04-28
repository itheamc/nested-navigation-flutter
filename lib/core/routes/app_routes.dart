import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_nested_navigation/ui/shared/nav_item_page_wrapper.dart';
import 'package:multi_nested_navigation/ui/views/home/home_screen.dart';
import 'package:multi_nested_navigation/ui/views/home/new_screen_2.dart';
import 'package:multi_nested_navigation/ui/views/map_screen.dart';
import 'package:multi_nested_navigation/ui/views/saved_screen.dart';
import 'package:multi_nested_navigation/ui/views/splash_screen.dart';
import 'package:multi_nested_navigation/ui/views/task_screen.dart';

import '../../ui/shared/a_bottom_navigation.dart';
import '../../ui/shared/scaffold_with_navbar.dart';
import '../../ui/views/home/new_screen_1.dart';

class AppRoutes1 {
  static const root = "/";
  static const home = "/home";
  static const map = "/map";
  static const saved = "/saved";
  static const tasks = "/tasks";

  /// Paths that will be visited from home
  static const newScreen1 = "/new_screen_1";
  static const newScreen2 = "/new_screen_2";

  static String pathAsName(String path) => path.replaceAll("/", "");

  /// Root Navigator Key
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  /// Navigator key for root Shell Route
  static final shellNavigatorKey = GlobalKey<NavigatorState>();

  /// Navigator Key for bottom nav item
  static final navigatorKeys = {
    NavItem.home: GlobalKey<NavigatorState>(),
    NavItem.map: GlobalKey<NavigatorState>(),
    NavItem.saved: GlobalKey<NavigatorState>(),
    NavItem.tasks: GlobalKey<NavigatorState>(),
  };

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: root,
    routes: [
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) {
          return NavItemPageWrapper(
            key: state.pageKey,
            state: state,
            child: child,
          );
        },
        // pageBuilder: (context, state, child) {
        //   return CustomSlideTransition(
        //     key: state.pageKey,
        //     child: NavItemPageWrapper(
        //       state: state,
        //       child: child,
        //     ),
        //   );
        // },
        routes: [
          ShellRoute(
            navigatorKey: navigatorKeys[NavItem.home],
            pageBuilder: (_, state, child) => _pageBuilder(
              state: state,
              child: child,
            ),
            routes: [
              GoRoute(
                path: home,
                name: pathAsName(home),
                pageBuilder: (_, state) => _pageBuilder(
                  state: state,
                  child: const HomeScreen(),
                ),
              ),
              GoRoute(
                path: newScreen1,
                name: pathAsName(newScreen1),
                pageBuilder: (_, state) => _pageBuilder(
                  state: state,
                  child: const NewScreen1(),
                  transition: RouteTransition.slide,
                ),
              ),
              GoRoute(
                path: newScreen2,
                name: pathAsName(newScreen2),
                pageBuilder: (_, state) => _pageBuilder(
                  state: state,
                  child: const NewScreen2(),
                  transition: RouteTransition.slide,
                ),
              ),
            ],
          ),
          ShellRoute(
            navigatorKey: navigatorKeys[NavItem.map],
            pageBuilder: (_, state, child) => _pageBuilder(
              state: state,
              child: child,
            ),
            routes: [
              GoRoute(
                path: map,
                name: pathAsName(map),
                builder: (_, state) => MapScreen(
                  key: state.pageKey,
                ),
              ),
            ],
          ),
          ShellRoute(
            navigatorKey: navigatorKeys[NavItem.saved],
            pageBuilder: (_, state, child) => _pageBuilder(
              state: state,
              child: child,
            ),
            routes: [
              GoRoute(
                path: saved,
                name: pathAsName(saved),
                builder: (_, state) => SavedScreen(
                  key: state.pageKey,
                ),
              ),
            ],
          ),
          ShellRoute(
            navigatorKey: navigatorKeys[NavItem.tasks],
            pageBuilder: (_, state, child) => _pageBuilder(
              state: state,
              child: child,
            ),
            routes: [
              GoRoute(
                path: tasks,
                name: pathAsName(tasks),
                builder: (_, state) => TaskScreen(
                  key: state.pageKey,
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: root,
        name: "root",
        builder: (_, state) => SplashScreen(
          key: state.pageKey,
        ),
      ),
    ],
  );

  static Page<dynamic> _pageBuilder({
    required GoRouterState state,
    required Widget child,
    bool hasTransition = true,
    RouteTransition transition = RouteTransition.scale,
  }) {
    return hasTransition
        ? CustomTransitionPage(
            key: state.pageKey,
            child: child,
            transitionsBuilder: (_, animation, __, child) {
              if (transition == RouteTransition.scale) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              }

              return SlideTransition(
                position: animation.drive(
                  Tween(
                    begin: const Offset(1.5, 0),
                    end: Offset.zero,
                  ).chain(
                    CurveTween(curve: Curves.ease),
                  ),
                ),
                child: child,
              );
            },
          )
        : NoTransitionPage(child: child, key: state.pageKey);
  }
}

enum RouteTransition {
  scale,
  slide,
}

class AppRoutes {
  static const root = "/";
  static const home = "/home";
  static const map = "/map";
  static const saved = "/saved";
  static const tasks = "/tasks";

  /// Paths that will be visited from home
  static const newScreen1 = "/new_screen_1";
  static const newScreen2 = "/new_screen_2";

  static String pathAsName(String path) => path.replaceAll("/", "");

  /// Root Navigator Key
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  /// Navigator key for root Shell Route
  static final shellNavigatorKey = GlobalKey<NavigatorState>();

  /// Navigator Key for bottom nav item
  static final navigatorKeys = {
    NavItem.home: GlobalKey<NavigatorState>(),
    NavItem.map: GlobalKey<NavigatorState>(),
    NavItem.saved: GlobalKey<NavigatorState>(),
    NavItem.tasks: GlobalKey<NavigatorState>(),
  };

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: root,
    routes: [
      MyShellRoute(
        navigatorKey: shellNavigatorKey,
        tabs: NavItem.values,
        // builder: (context, state, child) {
        //   return NavItemPageWrapper(
        //     key: state.pageKey,
        //     state: state,
        //     child: child,
        //   );
        // },
        // pageBuilder: (context, state, child) {
        //   return CustomSlideTransition(
        //     key: state.pageKey,
        //     child: NavItemPageWrapper(
        //       state: state,
        //       child: child,
        //     ),
        //   );
        // },
        routes: [
          // ShellRoute(
          //   navigatorKey: navigatorKeys[NavItem.home],
          //   builder: (_, state, child) => child,
          //   routes: [
          //     GoRoute(
          //       path: home,
          //       name: pathAsName(home),
          //       builder: (_, state) => const HomeScreen(),
          //     ),
          //     GoRoute(
          //       path: newScreen1,
          //       name: pathAsName(newScreen1),
          //       builder: (_, state) => const NewScreen1(),
          //     ),
          //     GoRoute(
          //       path: newScreen2,
          //       name: pathAsName(newScreen2),
          //       builder: (_, state) => const NewScreen2(),
          //     ),
          //   ],
          // ),
          // ShellRoute(
          //   navigatorKey: navigatorKeys[NavItem.map],
          //   builder: (_, state, child) => child,
          //   routes: [
          //     GoRoute(
          //       path: map,
          //       name: pathAsName(map),
          //       builder: (_, state) => const MapScreen(),
          //     ),
          //   ],
          // ),
          // ShellRoute(
          //   navigatorKey: navigatorKeys[NavItem.saved],
          //   builder: (_, state, child) => child,
          //   routes: [
          //     GoRoute(
          //       path: saved,
          //       name: pathAsName(saved),
          //       builder: (_, state) => const SavedScreen(),
          //     ),
          //   ],
          // ),
          // ShellRoute(
          //   navigatorKey: navigatorKeys[NavItem.tasks],
          //   builder: (_, state, child) => child,
          //   routes: [
          //     GoRoute(
          //       path: tasks,
          //       name: pathAsName(tasks),
          //       builder: (_, state) => const TaskScreen(),
          //     ),
          //   ],
          // ),
          GoRoute(
            path: home,
            name: pathAsName(home),
            builder: (_, state) => const HomeScreen(),
          ),
          GoRoute(
            path: map,
            name: pathAsName(map),
            builder: (_, state) => const MapScreen(),
          ),
          GoRoute(
            path: saved,
            name: pathAsName(saved),
            builder: (_, state) => const SavedScreen(),
          ),
          GoRoute(
            path: tasks,
            name: pathAsName(tasks),
            builder: (_, state) => const TaskScreen(),
          ),
        ],
      ),
      GoRoute(
        path: root,
        name: "root",
        builder: (_, state) => SplashScreen(
          key: state.pageKey,
        ),
      ),
    ],
  );
}

class MyShellRoute extends ShellRoute {
  final List<NavItem> tabs;

  MyShellRoute({
    required this.tabs,
    GlobalKey<NavigatorState>? navigatorKey,
    List<RouteBase> routes = const <RouteBase>[],
    Key? scaffoldKey = const ValueKey('ScaffoldWithNavBar'),
  }) : super(
          navigatorKey: navigatorKey,
          routes: routes,
          builder: (context, state, Widget child) {
            return Stack(
              children: [
                // Needed to keep the (faux) shell navigator alive
                Offstage(child: child),
                ScaffoldWithNavBar(
                    tabs: tabs,
                    key: scaffoldKey,
                    currentNavigator: (child as HeroControllerScope).child as Navigator,
                    currentRouterState: state,
                    routes: routes),
              ],
            );
          },
        );
}
