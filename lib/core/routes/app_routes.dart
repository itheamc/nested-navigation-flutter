import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_nested_navigation/ui/views/home/home_screen.dart';
import 'package:multi_nested_navigation/ui/views/map_screen.dart';
import 'package:multi_nested_navigation/ui/views/saved_screen.dart';
import 'package:multi_nested_navigation/ui/views/splash_screen.dart';
import 'package:multi_nested_navigation/ui/views/task_screen.dart';

import '../../ui/shared/a_bottom_navigation.dart';
import '../../ui/views/main_wrapper/main_wrapper_screen.dart';
import '../../ui/views/new_screen_1.dart';
import '../../ui/views/new_screen_2.dart';
import '../../ui/views/new_screen_3.dart';

class AppRoutes {
  static const root = "/";
  static const home = "/home";
  static const map = "/map";
  static const saved = "/saved";
  static const tasks = "/tasks";

  /// Paths that will be visited from home
  static const newScreen1 = "new_screen_1";
  static const newScreen2 = "new_screen_2";
  static const newScreen3 = "new_screen_3";

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
        routes: [
          GoRoute(
            path: home,
            name: pathAsName(home),
            pageBuilder: (_, state) => _pageBuilder(
              state: state,
              child: const HomeScreen(),
              transitionType: TransitionType.fade,
            ),
            routes: [
              GoRoute(
                path: newScreen1,
                name: pathAsName(newScreen1),
                pageBuilder: (_, state) => _pageBuilder(
                  state: state,
                  child: const NewScreen1(),
                  transitionType: TransitionType.slide,
                ),
                routes: [
                  GoRoute(
                    path: newScreen3,
                    name: pathAsName(newScreen3),
                    pageBuilder: (_, state) => _pageBuilder(
                      state: state,
                      child: const NewScreen3(),
                      transitionType: TransitionType.slide,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: map,
            name: pathAsName(map),
            pageBuilder: (_, state) => _pageBuilder(
              state: state,
              child: const MapScreen(),
              transitionType: TransitionType.fade,
            ),
            routes: [
              GoRoute(
                path: newScreen2,
                name: pathAsName(newScreen2),
                pageBuilder: (_, state) => _pageBuilder(
                  state: state,
                  child: const NewScreen2(),
                  transitionType: TransitionType.slide,
                ),
              ),
            ],
          ),
          GoRoute(
            path: saved,
            name: pathAsName(saved),
            pageBuilder: (_, state) => _pageBuilder(
              state: state,
              child: const SavedScreen(),
              transitionType: TransitionType.fade,
            ),
          ),
          GoRoute(
            path: tasks,
            name: pathAsName(tasks),
            pageBuilder: (_, state) => _pageBuilder(
              state: state,
              child: const TaskScreen(),
              transitionType: TransitionType.fade,
            ),
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

  /// Page builder helper function
  static Page<T> _pageBuilder<T>({
    required GoRouterState state,
    required Widget child,
    TransitionType transitionType = TransitionType.none,
  }) {
    if (transitionType == TransitionType.none) {
      return NoTransitionPage<T>(child: child);
    }

    return CustomTransitionPage<T>(
      child: child,
      transitionsBuilder: (_, animation, secondaryAnimation, child) {
        if (transitionType == TransitionType.scale) {
          return ScaleTransition(scale: animation, child: child);
        }

        if (transitionType == TransitionType.fade) {
          return FadeTransition(opacity: animation, child: child);
        }

        if (transitionType == TransitionType.slide) {
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
        }

        return AlignTransition(
          alignment: animation.drive(
            Tween(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
            ).chain(
              CurveTween(curve: Curves.ease),
            ),
          ),
          child: child,
        );
      },
    );
  }
}

enum TransitionType {
  slide,
  scale,
  fade,
  align,
  none,
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
                MainWrapperScreen(
                  items: tabs,
                  key: scaffoldKey,
                  navigator: (child as HeroControllerScope).child as Navigator,
                  state: state,
                ),
              ],
            );
          },
        );
}
