import 'package:todo_app/utils/errors/failures.dart';

import '../../data/models/todo_model.dart';

abstract class TodoRepository {
  Future<({Failure? failure, List<Todo>? todos})> fetch();
  Future<({Failure? failure, List<Todo>? todos})> add(String text);
  Future<({Failure? failure, List<Todo>? todos})> update(Todo todo);
  Future<({Failure? failure, List<Todo>? todos})> delete(int id);
}
