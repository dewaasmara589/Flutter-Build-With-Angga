import 'package:d_input/d_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/providers/person_provider.dart';

import '../models/person.dart';

class PersonPage extends ConsumerWidget{
  const PersonPage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final edtName = TextEditingController();
    final edtAge = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Person'),
      ),
      body: ListView(
        padding: EdgeInsetsGeometry.all(20.0),
        children: [
          Row(
            children: [
              Expanded(
                  child: DInput(
                    controller: edtName,
                    hint: 'Name',
                  )
              ),
              IconButton(
                  onPressed: (){
                    ref.read(personNotifierProvider.notifier).updateName(edtName.text);
                  },
                  icon: Icon(Icons.save)
              )
            ],
          ),
          SizedBox(height: 20.0,),
          Row(
            children: [
              Expanded(
                  child: DInput(
                    controller: edtAge,
                    hint: 'Age',
                  )
              ),
              IconButton(
                  onPressed: (){
                    ref.read(personNotifierProvider.notifier).updateAge(int.parse(edtAge.text));
                  },
                  icon: Icon(Icons.save)
              )
            ],
          ),
          SizedBox(height: 20.0,),
          Consumer(
              builder: (context, wiRef, child){
                String name = wiRef.watch(personNotifierProvider.select((person) => person.name));
                return Text('Name: $name');
              }
          ),
          Consumer(
              builder: (context, wiRef, child){
                int age = wiRef.watch(personNotifierProvider.select((person) => person.age));
                return Text('Age: $age');
              }
          ),
        ],
      ),
    );
  }
  
}