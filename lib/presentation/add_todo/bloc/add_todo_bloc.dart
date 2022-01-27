import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_final/data/model/todo.dart';
import 'package:todo_final/data/repositories/todo_repository.dart';

part 'add_todo_event.dart';
part 'add_todo_state.dart';

class AddTodoBloc extends Bloc<AddTodoEvent, AddTodoState> {
  AddTodoBloc({
    required TodosRepository todosRepository,
    required Todo? initialTodo,
  })  : _todosRepository = todosRepository,
        super(
          AddTodoState(
            initialTodo: initialTodo,
            title: initialTodo?.title ?? '',
            description: initialTodo?.description ?? '',
          ),
        ) {
    on<EditTodoTitleChanged>(_onTitleChanged);
    on<EditTodoDescriptionChanged>(_onDescriptionChanged);
    on<EditTodoSubmitted>(_onSubmitted);
  }

  final TodosRepository _todosRepository;

  void _onTitleChanged(
    EditTodoTitleChanged event,
    Emitter<AddTodoState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onDescriptionChanged(
    EditTodoDescriptionChanged event,
    Emitter<AddTodoState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onSubmitted(
    EditTodoSubmitted event,
    Emitter<AddTodoState> emit,
  ) async {
    emit(state.copyWith(status: AddTodoStatus.loading));
    final todo = (state.initialTodo ?? Todo(title: '')).copyWith(
      title: state.title,
      description: state.description,
    );

    try {
      await _todosRepository.saveTodo(todo);
      emit(state.copyWith(status: AddTodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AddTodoStatus.failure));
    }
  }
}
