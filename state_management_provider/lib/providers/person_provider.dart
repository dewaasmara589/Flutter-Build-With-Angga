
import 'package:flutter/material.dart';
import 'package:state_management_provider/model/person.dart';

class PersonProvider extends ChangeNotifier {
  Person _data = Person('', 0);

  Person get data => _data;

  updateName(String n){
    // Cara 1 _data.age mengambil data lama age
    // _data = Person(n, _data.age);

    // Cara 2 use CopyWith
    _data = _data.copyWith(name: n);

    notifyListeners();
  }

  updateAge(int n){
    // Cara 1 _data.age mengambil data lama age
    // _data = Person(n, _data.age);

    // Cara 2 use CopyWith
    _data = _data.copyWith(age: n);

    notifyListeners();
  }
}