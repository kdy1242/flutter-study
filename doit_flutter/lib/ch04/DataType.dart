
void main() {
  // 문자열
  String data1 = 'hello';
  String data2 = "hello"; // '', "" 둘 다 사용 가능
  String data3 = '''
                    hello
                    world
                  ''';
  String data4 = """  
                    hello
                    world
                  """;     // 여러줄 문자열

  print(data1 == data2);   // 문자열 같은지 비교

  int no = 10;
  print('$data1 $no');     // 문자열 템플릿

  // 형변환
  int n1 = 10;
  double d1 = 10.0;
  String s1 = '10';

  double d2 = n1.toDouble();  // n1을 double형으로 변환
  int n2 = d1.toInt();        // d1을 Int형으로 반환
  String s2 = n1.toString();  // n1을 String형으로 변환
  int n3 = int.parse(s1);     // s1을 int형으로 변환

}