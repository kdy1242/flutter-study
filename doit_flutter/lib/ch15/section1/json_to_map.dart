
import 'dart:convert';

// Map 형식으로 데이터 변환하기
jsonToMap() {
  String jsonStr = '{"id": 1, "title": "HELLO", "completed": false}';

  Map<String, dynamic> map = jsonDecode(jsonStr);
  print('id: ${map['id']}, title: ${map['title']}, completed: ${map['completed']}');
}

// List 타입 데이터 인코딩
listEncoding() {
  String jsonStr = '[{"id": 1, "title": "HELLO", "completed": false}, {"id": 2, "title": "WORLD", "completed": false}]';
  List list = jsonDecode(jsonStr);
  var list1 = list[0];
  if (list1 is Map) {
    print('id: ${list1['id']}, title: ${list1['title']}, completed: ${list1['completed']}');
  }
}

toJson() {
  String mapJsonStr = '{"id": 1, "title": "HELLO", "completed": false}';
  String listJsonStr = '[{"id": 1, "title": "HELLO", "completed": false}, {"id": 2, "title": "WORLD", "completed": false}]';

  // Map -> Json
  print('encode: ${jsonEncode(mapJsonStr)}');

  // list -> Json
  print('encode: ${jsonEncode(listJsonStr)}');
}

void main() {
  // jsonToMap();
  // listEncoding();
  toJson();
}
