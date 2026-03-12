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
        path: "/profile",
        builder: (context, state)  {
          return ProfilePage();
        }
      )
    ]
  );
}