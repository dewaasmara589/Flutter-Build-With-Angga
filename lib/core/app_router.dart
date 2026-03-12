import 'package:go_router/go_router.dart';
import 'package:modern_navigation_go_router/module/profile/profile_page.dart';

import '../module/home/home_page.dart';

class AppRouter {
  // Initialising
  AppRouter._();

  static GoRouter router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state)  {
          return HomePage();
        }
      ),
      GoRoute(
        // parsing data use path
        path: "/profile/:id/:tab",
        builder: (context, state)  {
          final id = state.pathParameters["id"] ?? "";
          final tab = state.pathParameters["tab"] ?? "";

          // final idFromQueryParam = state.uri.queryParameters["id_query"] ?? "";
          // test multiple param
          final idFromQueryParam = state.uri.queryParameters["id_query2"] ?? "";

          // Extra hanya bagus untuk apk mobile, kelemahan bahaya jika di refresh di website
          final idFromExtra = state.extra as String?;

          return ProfilePage(
            id:id,
            tab:tab,
            idFromQueryParam: idFromQueryParam,
            idFromExtra:idFromExtra ?? "",
          );
        }
      )
    ]
  );
}