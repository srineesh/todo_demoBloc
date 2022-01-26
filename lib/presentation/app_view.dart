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
      child: AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const HomeView());
  }
}
