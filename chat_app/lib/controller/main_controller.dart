
import 'package:chat_app/model/user.dart';
import 'package:chat_app/util/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../service/db_service.dart';
import 'auth_controller.dart';

class MainController extends GetxController {
  User get user => FirebaseAuth.instance.currentUser!;
  UserModel get userData => Get.find<AuthController>().userData!;
  TextEditingController createGroupController = TextEditingController();

  logout() => AuthController().logout();

  search() => Get.toNamed(AppRoutes.search);

  createGroup() {
    DBService(uid: user.uid).createGroup(createGroupController.text);
    Get.back();
    Get.snackbar(
      '그룹 생성',
      '그룹이 성공적으로 생성되었습니다.',
    );
  }

  @override
  void onInit() async {
    super.onInit();
    print('${userData}');
  }
}
