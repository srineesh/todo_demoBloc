import '../data_provider/todos_api.dart';
import '../model/todo.dart';

//This will get data from multiple data providers(*if needed) and pass them on the bloc which inturn sends them to ui for the user to see.
class TodosRepository {
  TodosRepository({required TodosApi todosApi}) : _todosApi = todosApi;

  final TodosApi _todosApi;

  Stream<List<Todo>> getTodos() => _todosApi.getTodos();

  Future<void> saveTodo(Todo todo) => _todosApi.saveTodo(todo);

  Future<void> deleteTodo(String id) => _todosApi.deleteTodo(id);

  Future<int> clearCompleted() => _todosApi.clearCompleted();

  Future<int> completeAll({required bool isCompleted}) =>
      _todosApi.completeAll(isCompleted: isCompleted);
}
