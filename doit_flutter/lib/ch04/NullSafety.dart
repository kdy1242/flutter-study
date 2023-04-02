
nullable() {
  int a1 = 10;
  int? a2 = 10; // null 허용

  //a1 = null;  // 오류
  a2 = null;


  var v1 = 10;
  var v2 = null;
  var v3;
  // var? v4 = null; // 오류

  dynamic b1 = 10;
  dynamic b2;
  dynamic b3 = null;


  // 형변환
  int c1 = 10;
  int? c2 = 10;

  c1 = c2;  // 오류
  c2 = c1;

  // 명시적 형변환
  c1 = a2 as int;

  int d1;
  late int d2;
}

nullOperator() {
  // ! : null인지 점검
  int? a1 = 20;
  a1!;
  a1 = null;
  a1!;


  // ?.
  int? no1 = 10;
  bool? res1 = no1?.isEven;
  print('result1 : $res1'); // true

  no1 = null;
  bool? res2 = no1?.isEven;
  print('result2 : $res2'); // null


  // ?[]
  List<int>? list = [10, 20, 30];
  print('list[0] : ${list?[0]}'); // 10

  list = null;
  print('list[0] : ${list?[0]}'); // null


  // ??=
  int? d3;
  d3 ??= 10;
  print('data3: $d3');  // 10
  d3 ??= null;
  print('data3: $d3');  // 10

  // ??
  String? d4 = 'hello';
  String? res = d4 ?? 'world';
  print('result: $res');  // hello

  d4 = null;
  res = d4 ?? 'world';
  print('result: $res');  // world

}

int? some(arg) {
  if(arg == 10) {
    return 0;
  } else {
    return null;
  }
}

main() {
  // int a = some(10)!;
  // print('a : $a');    // a : 0
  // int b = some(20)!;
  // print('b : $b');    // some() 함수가 null을 반환하므로 런타임에러


}
