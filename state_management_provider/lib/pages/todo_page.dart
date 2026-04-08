import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_provider/pages/animals_page.dart';
import 'package:state_management_provider/providers/todo_provider.dart';

class TodoPage extends StatelessWidget{
  const TodoPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: AnimalsPage(),
    );
  }
  
}