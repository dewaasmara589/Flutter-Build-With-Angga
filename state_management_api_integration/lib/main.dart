import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_api_integration/pages/game_page.dart';
import 'package:state_management_api_integration/provider/game_provider.dart';
import 'package:state_management_api_integration/provider/genre_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameProvider()),
        ChangeNotifierProvider(create: (context) => GenreProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        home: GamePage(),
      ),
    );
  }
}
