import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/todo_model.dart';
import '../../logic/cubits/todo_cubit.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          return switch (state) {
            TodoEmptyState() => const Text("Burası Boş"),
            TodoDataChangedState(currentTodos: var todos) => Expanded(
                child: ListView.separated(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final Todo todo = todos[index];
                    return _todoItem(todo, context);
                  },
                  separatorBuilder: (context, index) => Divider(
                    height: 0,
                    color: Colors.blueGrey.shade100,
                  ),
                ),
              ),
            _ => const CircularProgressIndicator()
          };
        },
      );

  ListTile _todoItem(Todo todo, BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    return ListTile(
      title: Text(
        todo.text,
        style: !todo.isDone
            ? null
            : const TextStyle(decoration: TextDecoration.lineThrough),
      ),
      subtitle: Text(todo.datetime.toString()),
      tileColor: Colors.grey.shade100,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () => todoCubit.deleteTodo(todo.id),
              icon: const Icon(Icons.close)),
          Checkbox(
            value: todo.isDone,
            onChanged: (isDone) {
              todo.isDone = isDone ?? false;
              todoCubit.updateTodo(todo);
            },
          ),
        ],
      ),
    );
  }
}
