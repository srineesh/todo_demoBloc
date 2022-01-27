part of 'add_todo_bloc.dart';

abstract class AddTodoEvent extends Equatable {
  const AddTodoEvent();

  @override
  List<Object> get props => [];
}

class EditTodoTitleChanged extends AddTodoEvent {
  const EditTodoTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

class EditTodoDescriptionChanged extends AddTodoEvent {
  const EditTodoDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class EditTodoSubmitted extends AddTodoEvent {
  const EditTodoSubmitted();
}
