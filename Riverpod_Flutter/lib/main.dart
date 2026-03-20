import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/pages/counter_page.dart';
import 'package:riverpod_flutter/pages/home_page.dart';
import 'package:riverpod_flutter/pages/todo_page.dart';

void main() {
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
      },
    );
  }
}
