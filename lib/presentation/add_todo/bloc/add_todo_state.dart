part of 'add_todo_bloc.dart';

enum AddTodoStatus { initial, loading, success, failure }

extension AddTodoStatusX on AddTodoStatus {
  bool get isLoadingOrSuccess => [
        AddTodoStatus.loading,
        AddTodoStatus.success,
      ].contains(this);
}

class AddTodoState extends Equatable {
  const AddTodoState({
    this.status = AddTodoStatus.initial,
    this.initialTodo,
    this.title = '',
    this.description = '',
  });

  final AddTodoStatus status;
  final Todo? initialTodo;
  final String title;
  final String description;

  bool get isNewTodo => initialTodo == null;

  AddTodoState copyWith({
    AddTodoStatus? status,
    Todo? initialTodo,
    String? title,
    String? description,
  }) {
    return AddTodoState(
      status: status ?? this.status,
      initialTodo: initialTodo ?? this.initialTodo,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [status, initialTodo, title, description];
}
