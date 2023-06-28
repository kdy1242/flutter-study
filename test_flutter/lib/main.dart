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
  void getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = '배터리: $result%';
    } on PlatformException catch (e) {
      batteryLevel = '실패: ${e.message}';
    }
    log(batteryLevel);
  }

  @override
  Widget build(BuildContext context) {
    getBatteryLevel();
    return Scaffold(
      appBar: AppBar(
        title: Text("Method Channel Test"),
      ),
    );
  }
}
