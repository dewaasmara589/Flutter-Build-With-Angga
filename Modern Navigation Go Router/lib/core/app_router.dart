import 'package:go_router/go_router.dart';
import 'package:modern_navigation_go_router/module/event/event_page.dart';
import 'package:modern_navigation_go_router/module/event_detail/event_detail_page.dart';
import 'package:modern_navigation_go_router/module/profile/profile_page.dart';

import '../module/edit_profile/edit_profile_page.dart';
import '../module/home/home_page.dart';

class AppRouter {
  // Initialising
  AppRouter._();

  static GoRouter router = GoRouter(
    initialLocation: "/",

    // Dengan go router maka navigasi akan close halaman sebelumnya atau replace
    // tidak seperti push
    // Dapat dilihat atau cek dengan Flutter Inspector -> Widget Tree

    routes: [
      // FLAT ROUTE karena 1 level saja
      GoRoute(
        path: "/",
        builder: (context, state)  {
          return HomePage();
        },
        // NESTED ROUTE
        routes: [
          GoRoute(
              path: "event",
              builder: (context, state)  {
                return EventPage();
              },
              routes: [
                GoRoute(
                    path: "detail",
                    builder: (context, state)  {
                      return EventDetailPage();
                    }
                )
              ]
          )
        ]
      ),
      GoRoute(
        // parsing data use path
        // path: "/profile/:id/:tab",
        path: "/profile/:id",
        builder: (context, state)  {
          final id = state.pathParameters["id"] ?? "";
          // final tab = state.pathParameters["tab"] ?? "";

          // final idFromQueryParam = state.uri.queryParameters["id_query"] ?? "";
          // test multiple param
          final idFromQueryParam = state.uri.queryParameters["id_query2"] ?? "";

          // Extra hanya bagus untuk apk mobile, kelemahan bahaya jika di refresh di website
          final idFromExtra = state.extra as String?;

          return ProfilePage(
            id:id,
            // tab:tab,
            idFromQueryParam: idFromQueryParam,
            idFromExtra:idFromExtra ?? "",
          );
        }
      ),
      GoRoute(
        // parsing data use path
        path: "/profile/:id/edit",
        builder: (context, state)  {
          final id = state.pathParameters["id"] ?? "";
          return EditProfilePage(
            id:id,
          );
        }
      )
    ]
  );
}