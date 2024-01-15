part of 'todo_cubit.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

final class TodoEmptyState extends TodoState {}

final class TodoLoadingState extends TodoState {}

final class TodoDataChangedState extends TodoState {
  final List<Todo> currentTodos;
  const TodoDataChangedState(this.currentTodos);

  @override
  List<Object> get props => [currentTodos];
}

final class TodoErrorState extends TodoState {
  final String message;
  const TodoErrorState(this.message);

  @override
  List<Object> get props => [message];
}
