
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/main_controller.dart';

class MainPage extends GetView<MainController> {
  const MainPage({Key? key}) : super(key: key);
  static const String route = '/main';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,   // 자동 뒤로가기 버튼 생성 비활성화
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(child: Column(
        children: [
          Text('main'),
          TextButton(
            onPressed: controller.logout,
            child: Text('logout'),
          )
        ],
      )),
    );
  }
}
