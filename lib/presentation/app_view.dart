import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/todo_repository.dart';
import 'home_view.dart';

class App extends StatelessWidget {
  final TodosRepository todosRepository;
  const App({
    Key? key,
    required this.todosRepository,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: todosRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TodosOverviewPage());
  }
}
