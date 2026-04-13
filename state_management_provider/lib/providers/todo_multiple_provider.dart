
import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:state_management_provider/model/animal.dart';
import 'package:uuid/uuid.dart';

class TodoMultipleProvider extends ChangeNotifier {
  List<Animal> _animals = [];
  List<Animal> get animals => _animals;

  // Bisa digunakan untuk ambil data dari database
  getAnimal(){
    _animals = [
      Animal(id: 'id', name: 'Cat', species: 'Mammal')
    ];
  }

  add(String name, String species, BuildContext context) {
    // Handle nama yang sama atau sudah ada
    int indexFound = _animals.indexWhere((e) => e.name.toLowerCase() == name.toLowerCase());
    if(indexFound>=0){
      DInfo.snackBarError(context, 'Name already added');
      // untuk stop program
      return;
    }

    Animal newAnimal = Animal(
        id: Uuid().v4(),
        name: name,
        species: species
    );
    _animals.add(newAnimal);
    notifyListeners();
  }

  remove(Animal animal) {
    _animals.removeWhere((element) => element.id == animal.id);
    notifyListeners();
  }

  update(String oldId, String name, String species){
    int index = _animals.indexWhere((e) => e.id == oldId);
    // Cara 1
    // Animal newAnimal = Animal(
    //     id: oldId,
    //     name: name,
    //     species: species
    // );
    // _animals[index] = newAnimal;

    // Cara 2
    _animals[index] = Animal(
        id: oldId,
        name: name,
        species: species
    );

    notifyListeners();
  }
}