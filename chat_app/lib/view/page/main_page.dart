
import 'package:chat_app/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
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
            onPressed: (){
              Get.find<AuthController>().logout();
            },
            child: Text('logout'),
          )
        ],
      )),
    );
  }
}
