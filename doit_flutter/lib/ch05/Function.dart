
void some1() {

}
void some2() {
  void some3() {

  }
  some3();
}
class MyClass {
  void some4() {

  }

  // void some4(int a) {  // 함수 오버로딩 제공 안함(대신 옵셔널 매개변수 제공)
  //
  // }
}

// 매개변수 타입
void func1(int? a) { }
void func2(var a, b) {  // a, b는 dynamic 타입
  a = 20;
  a = 'world';
  a = true;
  a = null;
  b = 20;
  b = 'world';
  b = true;
  b = null;
}

// 함수의 반환 타입
void func3(){}
int func4(){
  return 10;
}
func5() {}  // 호출 시 null

// 화살표 함수
void printUser1() {
  print('hello world');
}

void printUser2() => print('hello world');

void main() {
  func1(10);
}
