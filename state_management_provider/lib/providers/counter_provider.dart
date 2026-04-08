
import 'package:flutter/cupertino.dart';

class CounterProvider extends ChangeNotifier{
  // dengan awalan _ berarti variable private
  int _counter = 0;
  int get counter => _counter;
  // n membuat nilai baru
  // set counter(int n) => _counter = n;

  increment() {
    _counter++;
    // trigger update in UI
    notifyListeners();
  }
  decrement() {
    if (_counter > 0){
      _counter--;
    }

    notifyListeners();
  }
}