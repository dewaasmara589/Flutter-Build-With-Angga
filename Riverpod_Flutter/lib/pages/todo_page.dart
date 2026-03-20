import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/models/todo.dart';
import 'package:riverpod_flutter/providers/todo_provider.dart';

class TodoPage extends ConsumerStatefulWidget {
  const TodoPage({super.key});

  @override
  ConsumerState<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends ConsumerState<TodoPage> {
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => buildAdd(context),
        child: Icon(Icons.add),
      ),
      body: Consumer(
          builder: (context, wiRef, child) {
            List<Todo> todos = wiRef.watch(todoNotifierProvider);
            return ListView.builder(
              itemCount: todos.length,
                itemBuilder: (context, index) {
                  Todo todo = todos[index];
                  return ListTile(
                    leading: IconButton.filledTonal(
                        onPressed: () {
                          buildUpdate(todo);
                        },
                        icon: Icon(Icons.edit)
                    ),
                    title: Text(todo.title),
                    subtitle: Text(todo.body),
                    trailing: IconButton.filledTonal(
                        onPressed: () {
                          ref.read(todoNotifierProvider.notifier).remove(todo.id);
                        },
                        icon: Icon(Icons.delete)
                    ),
                  );
                }
            );
          },
      )
    );
  }

  buildAdd(BuildContext context) {
    final edtTitle = TextEditingController();
    final edtBody = TextEditingController();
    showDialog(context: context, builder: (context) => SimpleDialog(
      title: Text('Add Todo'),
      contentPadding: EdgeInsetsGeometry.all(20),
      children: [
        TextField(controller: edtTitle, decoration: InputDecoration(hintText: 'Title',),),
        SizedBox(height: 20.0,),
        TextField(controller: edtBody, decoration: InputDecoration(hintText: 'Body',),),
        SizedBox(height: 20.0,),
        ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
              ref.read(todoNotifierProvider.notifier).add(edtTitle.text, edtBody.text);
            },
            child: Text('Save')
        ),
      ],
    ));
  }

  buildUpdate(Todo oldTodo) {
    final edtTitle = TextEditingController();
    final edtBody = TextEditingController();
    edtTitle.text = oldTodo.title;
    edtBody.text = oldTodo.body;

    showDialog(context: context, builder: (context) => SimpleDialog(
      title: Text('Update Todo'),
      contentPadding: EdgeInsetsGeometry.all(20),
      children: [
        TextField(controller: edtTitle,),
        SizedBox(height: 20.0,),
        TextField(controller: edtBody,),
        SizedBox(height: 20.0,),
        ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
              Todo todoUpdated = oldTodo.copyWith(
                title: edtTitle.text,
                body: edtBody.text,
              );
              ref.read(todoNotifierProvider.notifier).update(todoUpdated);
            },
            child: Text('Save')
        ),
      ],
    ));
  }
}