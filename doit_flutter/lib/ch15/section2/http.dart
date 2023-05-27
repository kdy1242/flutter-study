
import 'package:http/http.dart' as http;

void main() async {
  // httpGet();
  // getWithHeader();
  // httpPost();
  httpClient();
}

// get
httpGet() async {
  http.Response res = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

  if (res.statusCode == 200) {
    String result = res.body;
    print(result);
  }
}

// 헤더 설정
getWithHeader() async {
  Map<String, String> headers = {
    'content-type': 'application/json',
    'accept': 'application/json',
  };

  http.Response res = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'), headers: headers);

  if (res.statusCode == 200) {
    String result = res.body;
    print(result);
  }
}

// post
httpPost() async {
  http.Response res = await http.post(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'), body: {'title': 'hello', 'body': 'world', 'userId': '1'});
}

httpClient() async {
  var client = http.Client();
  try {
    http.Response res = await client.post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: {'title': 'hello', 'body': 'world', 'userId': '1'});

    if (res.statusCode == 200 || res.statusCode == 201) {
      res = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
      print('res: ${res.body}');
    } else {
      print('error');
    }
  } finally {
    client.close();
  }
}
