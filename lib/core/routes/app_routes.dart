import 'package:go_router/go_router.dart';
import 'package:multi_nested_navigation/ui/views/home_screen.dart';
import 'package:multi_nested_navigation/ui/views/map_screen.dart';
import 'package:multi_nested_navigation/ui/views/saved_screen.dart';
import 'package:multi_nested_navigation/ui/views/task_screen.dart';

class AppRoutes {
  static const home = "/";
  static const map = "/map";
  static const saved = "/saved";
  static const task = "/task";

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: home,
        builder: (_, state) => const HomeScreen(),
      ),
      GoRoute(
        path: map,
        builder: (_, state) => const MapScreen(),
      ),
      GoRoute(
        path: saved,
        builder: (_, state) => const SavedScreen(),
      ),
      GoRoute(
        path: task,
        builder: (_, state) => const TaskScreen(),
      ),
    ],
  );
}
