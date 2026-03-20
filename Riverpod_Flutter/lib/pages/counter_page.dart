import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/pages/todo_page.dart';
import 'package:riverpod_flutter/providers/counter_provider.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build Page');
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(top: 10.0, left: 10.0),
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TodoPage()));
              },
              child: Text("Todo Page"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Background color
                foregroundColor: Colors.white, // Text/icon color
              ),
            ),
          ),
          Center(
            child: Consumer(
                builder: (context, wiRef, child) {
                  print('build Text Counter');
                  int counter = wiRef.watch(counterNotifierProvider);
                  return Text("$counter");
                }
            ),
          ),
        ],
      ),
      floatingActionButton: ButtonBar(
        children: [
          FloatingActionButton(
            heroTag: 'decrement',
            child: const Icon(Icons.remove),
            onPressed: (){
              ref.read(counterNotifierProvider.notifier).decrement();
            },
          ),
          FloatingActionButton(
            heroTag: 'increment',
            child: const Icon(Icons.add),
            onPressed: (){
              ref.read(counterNotifierProvider.notifier).increment();
            },
          )
        ],
      ),
    );
  }
}