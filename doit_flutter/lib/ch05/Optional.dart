
// Optional

// 명명된 매개변수 (named parameter)
// void some1({String? data1, bool? data2}, int data3) {}  // 오류
// void some2(int data1, {String? data2, bool? data3}, {int? data4}) {} // 오류
void some3(int data1, {String? data2, bool? data3}) {}  // 성공

// some3();  // 오류
// some3(10);  // 성공
// some3(10, 'hello', true); // 오류
// some3(10, data2: 'hello', data3: true);  // 성공
// some3(10, data3: true, data2: 'hello');  // 성공
// some3(data2: 'hello', 10, data3: true);  // 성공

String func1({String data = 'hello'}) {
  return data;
}

func2({required int arg1}) {}


// 옵셔널 위치 매개변수 (optional positional parameter)
void func(int arg1, [String arg2 = 'hello', bool arg3 = false]) {}

void main() {
  // func(); // 오류
  // func(10); // 성공
  // func(10, arg2: 'world', arg3: true);  // 오류
  // func(10, 'world', true);  // 성공
  // func(10, true, 'world');  // 오류
  // func(10, 'world');  // 성공
  // func(10, true); // 오류
}
