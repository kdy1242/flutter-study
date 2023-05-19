
import 'package:json_annotation/json_annotation.dart';
part 'json_serializable.g.dart';

@JsonSerializable()
class Todo {
  @JsonKey(name: 'id')
  int id;
  String title;
  bool completed;

  Todo({
    required this.id,
    required this.title,
    required this.completed,
  });

  factory Todo.fromMap(Map<String, dynamic> map) => _$TodoFromJson(map);
  Map<String, dynamic> toMap() => _$TodoToJson(this);
}
