
import 'package:chat_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';


class MainController extends GetxController {
  User get user => FirebaseAuth.instance.currentUser!;
  UserModel get userData => Get.find<AuthController>().userData!;

  logout() => AuthController().logout();

  @override
  void onInit() async {
    super.onInit();
    print('${userData}');
  }
}
