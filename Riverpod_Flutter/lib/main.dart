import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/pages/counter_page.dart';
import 'package:riverpod_flutter/pages/home_page.dart';
import 'package:riverpod_flutter/pages/live_game_page.dart';
import 'package:riverpod_flutter/pages/todo_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(
      const ProviderScope(
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
      routes: {
        "/counter": (context) => const CounterPage(),
        "/todo": (context) => const TodoPage(),
        "/livegame": (context) => const LiveGamePage(),
      },
    );
  }
}
