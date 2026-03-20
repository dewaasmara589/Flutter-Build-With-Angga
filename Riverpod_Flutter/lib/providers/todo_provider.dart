
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_flutter/models/todo.dart';
import 'package:uuid/uuid.dart';

// tambahkan ini lalu jalankan di terminal 'dart run build_runner watch'
part 'todo_provider.g.dart';

// menyimpan data state agar tidak dihapus ketika pindah halaman
@Riverpod(keepAlive: true)
class TodoNotifier extends _$TodoNotifier {
  @override
  List<Todo> build() => <Todo>[];

  add(String title, String body){
    Todo newTodo = Todo(
        id: const Uuid().v4(),
        title: title,
        body: body,
    );
    // ...state mengambil list data yang lama + yang baru dari newTodo menjadi list baru untuk state
    state = [...state, newTodo];
  }

  update(Todo newTodo){
    int index = state.indexWhere((element) => element.id == newTodo.id);
    state[index] = newTodo;
    state = [...state];
  }

  remove(String id){
    state.removeWhere((element) => element.id == id);
    state = [...state];
  }
}