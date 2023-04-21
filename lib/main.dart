import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_nested_navigation/core/routes/app_routes.dart';
import 'package:multi_nested_navigation/main_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      builder: (_, child) => MainPage(
        child: child,
        // navigate: (i) {
        //   final route = i == 0
        //       ? AppRoutes.home
        //       : i == 1
        //           ? AppRoutes.map
        //           : i == 2
        //               ? AppRoutes.saved
        //               : AppRoutes.task;
        //   context.go(route);
        // },
      ),
      routerConfig: RouterConfig(
        routerDelegate: AppRoutes.router.routerDelegate,
        routeInformationParser: AppRoutes.router.routeInformationParser,
        routeInformationProvider: AppRoutes.router.routeInformationProvider,
        backButtonDispatcher: AppRoutes.router.backButtonDispatcher,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
