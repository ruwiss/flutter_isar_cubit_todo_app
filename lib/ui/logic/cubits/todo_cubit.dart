import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/utils/errors/failures.dart';

import '../../data/models/todo_model.dart';
import '../repositories/todo_repository.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository _databaseRepository;
  TodoCubit(this._databaseRepository) : super(TodoLoadingState());

  @override
  void emit(TodoState state) {
    if (state is TodoDataChangedState && state.currentTodos.isEmpty) {
      emit(TodoEmptyState());
    } else {
      super.emit(state);
    }
  }

  void _emitTodoListData(
      Future<({Failure? failure, List<Todo>? todos})> futureData) async {
    final result = await futureData;
    final failure = result.failure;
    final todos = result.todos;
    try {
      if (failure != null) {
        emit(TodoErrorState(failure.message));
      } else if (todos != null) {
        emit(TodoDataChangedState(todos));
      }
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  void fetchTodos() => _emitTodoListData(_databaseRepository.fetch());

  void addTodo(String text) => _emitTodoListData(_databaseRepository.add(text));

  void updateTodo(Todo todo) =>
      _emitTodoListData(_databaseRepository.update(todo));

  void deleteTodo(int id) => _emitTodoListData(_databaseRepository.delete(id));
}
