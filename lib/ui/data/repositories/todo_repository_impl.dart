import 'package:todo_app/utils/errors/exceptions.dart';
import 'package:todo_app/utils/errors/failures.dart';

import '../dataproviders/isar_database.dart';
import '../models/todo_model.dart';
import '../../logic/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final IsarDatabase _database = IsarDatabase();

  @override
  Future<({Failure? failure, List<Todo>? todos})> add(String text) async {
    try {
      final todos = await _database.addTodo(text);
      return (failure: null, todos: todos);
    } on DatabaseException catch (e) {
      return (failure: DatabaseFailure(e.message), todos: null);
    }
  }

  @override
  Future<({Failure? failure, List<Todo>? todos})> delete(int id) async {
    try {
      final todos = await _database.deleteTodo(id);
      return (failure: null, todos: todos);
    } on DatabaseException catch (e) {
      return (failure: DatabaseFailure(e.message), todos: null);
    }
  }

  @override
  Future<({Failure? failure, List<Todo>? todos})> fetch() async {
    try {
      final todos = await _database.fetchTodos();
      return (failure: null, todos: todos);
    } on DatabaseException catch (e) {
      return (failure: DatabaseFailure(e.message), todos: null);
    }
  }

  @override
  Future<({Failure? failure, List<Todo>? todos})> update(Todo todo) async {
    try {
      final todos = await _database.updateTodo(todo);
      return (failure: null, todos: todos);
    } on DatabaseException catch (e) {
      return (failure: DatabaseFailure(e.message), todos: null);
    }
  }
}
