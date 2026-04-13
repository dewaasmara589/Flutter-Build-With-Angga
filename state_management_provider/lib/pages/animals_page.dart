import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_provider/providers/todo_provider.dart';

class AnimalsPage extends StatelessWidget{
  const AnimalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animal'),
        backgroundColor: Colors.green,
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          List<String> animals = todoProvider.animals;
          if(animals.isEmpty) {
            return Center(child: Text('Empty'),);
          }

          return ListView.builder(
            itemCount: animals.length,
            itemBuilder: (context, index) {
              String animal = animals[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${index+1}'),
                ),
                title: Text(animal),
                trailing: IconButton(
                    onPressed: () {
                      todoProvider.remove(index);
                    },
                    icon: Icon(Icons.delete),
                ),
              );
            }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            final provider = context.read<TodoProvider>();
            buildAddAnimal(context, provider);
          },
        child: Icon(Icons.add),
      ),
    );
  }

  buildAddAnimal(BuildContext context, TodoProvider todoProvider){
    final edtAnimal = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add New Animal'),
            content: TextField(
              controller: edtAnimal,
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    todoProvider.add(edtAnimal.text);
                    Navigator.pop(context);
                  },
                  child: Text('Add')
              )
            ],
          );
        }
    );
  }
}