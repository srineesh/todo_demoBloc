import '../model/todo.dart';

/// This is the layer that communicates with the shared prefrences or sqflite database.

abstract class TodosApi {
  const TodosApi();

  Stream<List<Todo>> getTodos(); //Gets all todos

  // This will save a todo and if a todo already exists it will be replaced
  Future<void> saveTodo(Todo todo);

//This will deleteTodo
  Future<void> deleteTodo(String id);

//Will delete Complete todo and return the number of deleted todos
  Future<int> clearCompleted();

  /// Sets the `isCompleted` state of all todos to the given value.
  ///
  /// Returns the number of updated todos.
  Future<int> completeAll({required bool isCompleted});
}

class TodoNotFoundException implements Exception {}
