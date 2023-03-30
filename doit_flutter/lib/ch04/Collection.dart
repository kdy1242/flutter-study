
funcList() {
  List list1 = [10, 'hello', true];   // 리스트에 대입할 타입 정하지 않으면 dynamic 타입 리스트
  list1[0] = 20;
  list1[1] = 'world';
  print('List: $list1');  // List: [20, world, true]

  // generic
  List<int> list2 = [10, 20, 30];
  print(list2);

  list2.add(40);
  list2.add(50);
  print(list2);

  list2.removeAt(0);
  print(list2);

  var list3 = List<int>.filled(3, 0, growable: true);
  print(list3);

  var list4 = List<int>.generate(3, (index) => index*10, growable: true);
  print(list4);
}

funcSet() {
  Set<int> set1 = {10, 20, 10};
  print(set1);
  set1.add(30);
  set1.add(40);
  print(set1);

  Set<int> set2 = Set();
  set2.add(10);
  set2.add(20);
  print(set2);
}

funcMap() {
  Map<String, String> map1 = {'one':'hello', 'two':'world'};
  print(map1['one']);
  map1['one'] = 'world';
  print(map1['one']);
}

void main() {
  // funcList();
  // funcSet();
  funcMap();
}
