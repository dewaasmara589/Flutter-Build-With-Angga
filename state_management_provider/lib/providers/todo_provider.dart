
import 'package:flutter/cupertino.dart';

class TodoProvider extends ChangeNotifier{
  final List<String> _animals = [];
  List<String> get animals => _animals;

  add(String n) {
    _animals.add(n);
    notifyListeners();
  }

  remove(int index) {
    _animals.removeAt(index);
    notifyListeners();
  }
}