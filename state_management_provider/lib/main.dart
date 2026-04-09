import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_provider/pages/person_page.dart';
import 'package:state_management_provider/pages/todo_page.dart';
import 'package:state_management_provider/providers/person_provider.dart';
import 'package:state_management_provider/providers/todo_provider.dart';

import 'providers/counter_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        ChangeNotifierProvider(create: (_) => PersonProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
        routes: {
          '/todo': (context) => const TodoPage(),
          '/person': (context) => const PersonPage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // final int newCounter = context.watch<CounterProvider>().counter;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TodoPage()),
                    );
                  },
                  child: Text("ToDo"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                SizedBox(width: 20.0,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PersonPage()),
                    );
                  },
                  child: Text("Person"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            Spacer(),
            const Text('You have pushed the button this many times:'),
            // TODO implement counter provider use Consumer
            // Cara 1 rekomendasi cara tebaik
            Consumer<CounterProvider>(
              builder: (context, provider, child) {
                return Text(
                  '${provider.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              }
            ),

            // Cara 2 karena lebih berat harus render semua dari scaffold dan menurukan performa
            // Text(
            //   '$newCounter',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),

            // Cara 3 lebih baik
            // TextCounter(),

            Spacer(),
          ],
        ),
      ),
      floatingActionButton: ButtonBar(
        children: [
          FloatingActionButton(
            onPressed: (){
              Provider.of<CounterProvider>(context, listen: false).decrement();
            },
            heroTag: 'Decrement',
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: (){
              // Cara 1
              Provider.of<CounterProvider>(context, listen: false).increment();

              // Cara 2 extension provider
              // context.read<CounterProvider>().increment();

              // Cara 3 extension provider dengan listen: true
              // context.watch();
            },
            heroTag: 'Increment',
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      )
    );
  }
}

// TODO cara agar tidak perlu render semua untuk provider watch
class TextCounter extends StatelessWidget{
  const TextCounter({super.key});

  @override
  Widget build(BuildContext context) {
    final int newCounter = context.watch<CounterProvider>().counter;
    return Text(
      '$newCounter',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}