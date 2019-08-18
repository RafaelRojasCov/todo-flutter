import 'package:flutter/material.dart';
import './TodoList.dart';

void main() => runApp(MyTodoApp());

class MyTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(title: 'My awesome todo', home: new TodoList());
  }
}
