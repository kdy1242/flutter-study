
// 타입 추론
void main() {
  // 선언과 동시에 초기화
  var no = 10;
  no = 20;       // type: int
  // no = 'hello';  // 오류 발생

  // 선언만 하고 초깃값을 대입하지 않으면 dynamic 타입으로 선언됨
  var no2;  // type: dynamic
  no2 = 10;
  no2 = 'hello';
  no2 = true;    // dynamic 타입이기 때문에 여러 타입 대입 가능

  dynamic d = 10;
  d = 'hello';
  d = true;
}
