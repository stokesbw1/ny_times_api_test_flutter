import 'package:flutter/material.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/presentation/articles_screens.dart';
import 'package:ny_times_api_test_flutter/injection_container.dart';
import 'package:routemaster/routemaster.dart';

final routes = RouteMap(routes: {
  '/': (_) {
    return MaterialPage(
      child: ArticlesScreen(
        showToast: sl(),
        articleCubit: sl(),
        bookmarkCubit: sl(),
      ),
      // paths: ['/feed', '/settings'],
    );
  }
  // '/feed': (_) => MaterialPage(child: FeedPage()),
  // '/settings': (_) => MaterialPage(child: SettingsPage()),
  // '/feed/profile/:id': (info) =>
  //     MaterialPage(child: ProfilePage(id: info.pathParameters['id'])),
});
