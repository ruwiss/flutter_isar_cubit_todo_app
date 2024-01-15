import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubits/todo_cubit.dart';

class AddTodoWidget extends StatefulWidget {
  const AddTodoWidget({super.key});

  @override
  State<AddTodoWidget> createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  final _textFieldController = TextEditingController();

  void _addTodo() {
    final todoCubit = context.read<TodoCubit>();
    todoCubit.addTodo(_textFieldController.text);
    _textFieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: TextField(
        controller: _textFieldController,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: _addTodo,
            icon: const Icon(Icons.add),
          ),
          border: const OutlineInputBorder(),
          isDense: true,
          hintText: "Birşeyler yazın.",
        ),
      ),
    );
  }
}
