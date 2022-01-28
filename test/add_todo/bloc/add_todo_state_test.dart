// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_final/data/model/todo.dart';
import 'package:todo_final/presentation/add_todo/bloc/add_todo_bloc.dart';

void main() {
  group('AddTodoState', () {
    final mockInitialTodo = Todo(
      id: '1',
      title: 'title 1',
      description: 'description 1',
    );

    AddTodoState createSubject({
      AddTodoStatus status = AddTodoStatus.initial,
      Todo? initialTodo,
      String title = '',
      String description = '',
    }) {
      return AddTodoState(
        status: status,
        initialTodo: initialTodo,
        title: title,
        description: description,
      );
    }

    test('supports value equality', () {
      expect(
        createSubject(),
        equals(createSubject()),
      );
    });

    test('props are correct', () {
      expect(
        createSubject(
          status: AddTodoStatus.initial,
          initialTodo: mockInitialTodo,
          title: 'title',
          description: 'description',
        ).props,
        equals(<Object?>[
          AddTodoStatus.initial, // status
          mockInitialTodo, // initialTodo
          'title', // title
          'description', // description
        ]),
      );
    });

    test('isNewTodo returns true when a new todo is being created', () {
      expect(
        createSubject(
          initialTodo: null,
        ).isNewTodo,
        isTrue,
      );
    });

    group('copyWith', () {
      test('returns the same object if not arguments are provided', () {
        expect(
          createSubject().copyWith(),
          equals(createSubject()),
        );
      });

      test('retains the old value for every parameter if null is provided', () {
        expect(
          createSubject().copyWith(
            status: null,
            initialTodo: null,
            title: null,
            description: null,
          ),
          equals(createSubject()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createSubject().copyWith(
            status: AddTodoStatus.success,
            initialTodo: mockInitialTodo,
            title: 'title',
            description: 'description',
          ),
          equals(
            createSubject(
              status: AddTodoStatus.success,
              initialTodo: mockInitialTodo,
              title: 'title',
              description: 'description',
            ),
          ),
        );
      });
    });
  });
}
