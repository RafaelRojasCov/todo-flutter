import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  @override
  createState() => new _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  InputDecoration _inputDecoration = new InputDecoration(
      hintText: 'Enter something to task...',
      contentPadding: const EdgeInsets.all(16.0));

  TextField _myTodoDescription() {
    return new TextField(
      autofocus: true,
      onSubmitted: (val) {
        _addTodoItem(val);
        Navigator.pop(context);
      },
      decoration: _inputDecoration,
    );
  }

  FlatButton _cancelDelete() {
    return new FlatButton(
      child: new Text('CANCEL'),
      onPressed: () {
        return Navigator.of(context).pop();
      },
    );
  }

  FlatButton _markTaskAsDone(int index) {
    return new FlatButton(
        child: new Text('MARK AS DONE'),
        onPressed: () {
          _removeTodoItem(index);
          Navigator.of(context).pop();
        });
  }

  FloatingActionButton _addNewTask() {
    return new FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: new Icon(Icons.add));
  }

  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() {
        _todoItems.add(task);
      });
    }
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          appBar: new AppBar(title: new Text('Add a new task')),
          body: _myTodoDescription());
    }));
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('Mark "${_todoItems[index]}" as done?'),
            actions: <Widget>[_cancelDelete(), _markTaskAsDone(index)],
          );
        });
  }

  Widget _buildTodoList() {
    return new ListView.builder(itemBuilder: (context, index) {
      if (index < _todoItems.length) {
        return _buildTodoItem(_todoItems[index], index);
      }
    });
  }

  Widget _buildTodoItem(String todoText, int index) {
    return new ListTile(
      title: new Text(todoText),
      onTap: () => _promptRemoveTodoItem(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Todo List')),
      body: _buildTodoList(),
      floatingActionButton: _addNewTask(),
    );
  }
}
