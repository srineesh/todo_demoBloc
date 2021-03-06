import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  Todo({
    final String? id,
    required this.title,
    this.description = "",
    this.isCompleted = false,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory Todo.fromJson(Map<String, dynamic> data) => _$TodoFromJson(data);

  @override
  List<Object> get props => [id, title, description, isCompleted];
}
