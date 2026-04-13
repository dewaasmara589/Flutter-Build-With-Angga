
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_provider/model/animal.dart';
import 'package:state_management_provider/providers/todo_multiple_provider.dart';

class TodoMultiplePage extends StatefulWidget{
  const TodoMultiplePage({super.key});

  @override
  State<TodoMultiplePage> createState() => _TodoMultiplePageState();
}

class _TodoMultiplePageState extends State<TodoMultiplePage> {

  @override
  void initState() {
    context.read<TodoMultipleProvider>().getAnimal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animal (Multiple)'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Consumer<TodoMultipleProvider>(
          builder: (context, todoMultipleProvider, child) {
            List<Animal> animals = todoMultipleProvider.animals;
            if(animals.isEmpty) {
              return Center(child: Text('Empty'),);
            }

            return ListView.builder(
                itemCount: animals.length,
                itemBuilder: (context, index) {
                  Animal animal = animals[index];
                  return ListTile(
                    leading: IconButton.filledTonal(
                        onPressed: () {
                          final provider = context.read<TodoMultipleProvider>();
                          buildUpdateAnimal(context, provider, animal);
                        },
                        icon: Icon(Icons.edit)
                    ),
                    title: Text(animal.name),
                    subtitle: Text(animal.species),
                    trailing: IconButton(
                      onPressed: () {
                        todoMultipleProvider.remove(animal);
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
          final provider = context.read<TodoMultipleProvider>();
          buildAddAnimal(context, provider);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  buildAddAnimal(BuildContext context, TodoMultipleProvider todoProvider){
    final edtName = TextEditingController();
    final edtSpecies = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add New Animal'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: edtName,
                  decoration: InputDecoration(
                    labelText: 'Name'
                  ),
                ),
                SizedBox(height: 15.0,),
                TextField(
                  controller: edtSpecies,
                  decoration: InputDecoration(
                      labelText: 'Species'
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    todoProvider.add(edtName.text, edtSpecies.text, context);
                    Navigator.pop(context);
                  },
                  child: Text('Add')
              )
            ],
          );
        }
    );
  }

  buildUpdateAnimal(BuildContext context, TodoMultipleProvider todoProvider, Animal oldAnimal){
    final edtName = TextEditingController();
    final edtSpecies = TextEditingController();

    edtName.text = oldAnimal.name;
    edtSpecies.text = oldAnimal.species;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update Animal'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: edtName,
                  decoration: InputDecoration(
                      labelText: 'Name'
                  ),
                ),
                SizedBox(height: 15.0,),
                TextField(
                  controller: edtSpecies,
                  decoration: InputDecoration(
                      labelText: 'Species'
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    todoProvider.update(oldAnimal.id, edtName.text, edtSpecies.text);
                    Navigator.pop(context);
                  },
                  child: Text('Update')
              )
            ],
          );
        }
    );
  }
}