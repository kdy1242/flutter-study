
import 'dart:convert';

// 모델 클래스 만들어서 Json 데이터 매핑
class Todo {
  int id;
  String title;
  bool completed;

  Todo({
    required this.id,
    required this.title,
    required this.completed,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as int,
      title: map['title'] as String,
      completed: map['completed'] as bool,
    );
  }
}

void main() {
  String jsonStr = '{"id": 1, "title": "HELLO", "completed": false}';
  Map<String, dynamic> map = jsonDecode(jsonStr);
  Todo todo = Todo.fromMap(map);
  print(todo);
}
