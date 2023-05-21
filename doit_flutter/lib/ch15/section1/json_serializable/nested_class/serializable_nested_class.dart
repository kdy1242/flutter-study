
import 'package:json_annotation/json_annotation.dart';
part 'serializable_nested_class.g.dart';

// 모델 클래스에 모델 클래스를 중복해서 사용해야 하는 경우 두 클래스 모두에 어노테이션 추가해줘야함
@JsonSerializable()
class Location {
  String latitude;
  String longitude;

  Location(this.latitude, this.longitude);

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

// (explicitToJson: true): 중첩클래스 객체 출력 시 타입정보가 아니라 중첩클래스의 객체에 담긴 값이 출력됨
@JsonSerializable(explicitToJson: true)
class Todo {
  @JsonKey(name: "id")
  int todoId;
  String title;
  bool completed;
  Location location;  // 중첩 클래스

  Todo(this.todoId, this.title, this.completed, this.location);

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
