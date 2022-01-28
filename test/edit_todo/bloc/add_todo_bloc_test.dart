import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_final/data/model/todo.dart';
import 'package:todo_final/data/repositories/todo_repository.dart';
import 'package:todo_final/presentation/add_todo/bloc/add_todo_bloc.dart';

class MockTodosRepository extends Mock implements TodosRepository {}

class FakeTodo extends Fake implements Todo {}

void main() {
  group('AddTodoBloc', () {
    late TodosRepository todosRepository;

    setUpAll(() {
      registerFallbackValue(FakeTodo());
    });

    setUp(() {
      todosRepository = MockTodosRepository();
    });

    AddTodoBloc buildBloc() {
      return AddTodoBloc(
        todosRepository: todosRepository,
        initialTodo: null,
      );
    }

    group('constructor', () {
      test('works properly', () {
        expect(buildBloc, returnsNormally);
      });

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(const AddTodoState()),
        );
      });
    });

    group('EditTodoTitleChanged', () {
      blocTest<AddTodoBloc, AddTodoState>(
        'emits new state with updated title',
        build: buildBloc,
        act: (bloc) => bloc.add(const EditTodoTitleChanged('newtitle')),
        expect: () => const [
          AddTodoState(title: 'newtitle'),
        ],
      );
    });

    group('EditTodoDescriptionChanged', () {
      blocTest<AddTodoBloc, AddTodoState>(
        'emits new state with updated description',
        build: buildBloc,
        act: (bloc) =>
            bloc.add(const EditTodoDescriptionChanged('newdescription')),
        expect: () => const [
          AddTodoState(description: 'newdescription'),
        ],
      );
    });

    group('EditTodoSubmitted', () {
      blocTest<AddTodoBloc, AddTodoState>(
        'attempts to save new todo to repository '
        'if no initial todo was provided',
        setUp: () {
          when(() => todosRepository.saveTodo(any())).thenAnswer((_) async {});
        },
        build: buildBloc,
        seed: () => const AddTodoState(
          title: 'title',
          description: 'description',
        ),
        act: (bloc) => bloc.add(const EditTodoSubmitted()),
        expect: () => const [
          AddTodoState(
            status: AddTodoStatus.loading,
            title: 'title',
            description: 'description',
          ),
          AddTodoState(
            status: AddTodoStatus.success,
            title: 'title',
            description: 'description',
          ),
        ],
        verify: (bloc) {
          verify(
            () => todosRepository.saveTodo(
              any(
                that: isA<Todo>()
                    .having((t) => t.title, 'title', equals('title'))
                    .having(
                      (t) => t.description,
                      'description',
                      equals('description'),
                    ),
              ),
            ),
          ).called(1);
        },
      );

      blocTest<AddTodoBloc, AddTodoState>(
        'attempts to save updated todo to repository '
        'if an initial todo was provided',
        setUp: () {
          when(() => todosRepository.saveTodo(any())).thenAnswer((_) async {});
        },
        build: buildBloc,
        seed: () => AddTodoState(
          initialTodo: Todo(
            id: 'initial-id',
            title: 'initial-title',
          ),
          title: 'title',
          description: 'description',
        ),
        act: (bloc) => bloc.add(const EditTodoSubmitted()),
        expect: () => [
          AddTodoState(
            status: AddTodoStatus.loading,
            initialTodo: Todo(
              id: 'initial-id',
              title: 'initial-title',
            ),
            title: 'title',
            description: 'description',
          ),
          AddTodoState(
            status: AddTodoStatus.success,
            initialTodo: Todo(
              id: 'initial-id',
              title: 'initial-title',
            ),
            title: 'title',
            description: 'description',
          ),
        ],
        verify: (bloc) {
          verify(
            () => todosRepository.saveTodo(
              any(
                that: isA<Todo>()
                    .having((t) => t.id, 'id', equals('initial-id'))
                    .having((t) => t.title, 'title', equals('title'))
                    .having(
                      (t) => t.description,
                      'description',
                      equals('description'),
                    ),
              ),
            ),
          );
        },
      );

      blocTest<AddTodoBloc, AddTodoState>(
        'emits new state with error if save to repository fails',
        build: () {
          when(() => todosRepository.saveTodo(any()))
              .thenThrow(Exception('oops'));
          return buildBloc();
        },
        seed: () => const AddTodoState(
          title: 'title',
          description: 'description',
        ),
        act: (bloc) => bloc.add(const EditTodoSubmitted()),
        expect: () => const [
          AddTodoState(
            status: AddTodoStatus.loading,
            title: 'title',
            description: 'description',
          ),
          AddTodoState(
            status: AddTodoStatus.failure,
            title: 'title',
            description: 'description',
          ),
        ],
      );
    });
  });
}
