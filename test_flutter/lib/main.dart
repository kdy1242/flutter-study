import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // Method Channel 생성
  static const platform = MethodChannel('com.example.test_flutter');

  // 네이티브 메서드 호출
  Future<String> getBatteryLevel() async {
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      return '배터리: $result%';
    } on PlatformException catch (e) {
      return '실패: ${e.message}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Method Channel Test"),
      ),
      body: Center(
        child: FutureBuilder(
          future: getBatteryLevel(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!);
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
