import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_nested_navigation/core/routes/app_routes.dart';


final routeStateProvider = StateNotifierProvider<RouteStateNotifier, String>((ref) => RouteStateNotifier());

class RouteStateNotifier extends StateNotifier<String> {
  RouteStateNotifier() : super(AppRoutes.home);

  void updateRoute(String location) {
    state = location;
  }
}
