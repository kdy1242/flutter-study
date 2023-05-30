
import 'package:chat_app/model/user.dart';
import 'package:chat_app/util/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class MainController extends GetxController {
  User get user => FirebaseAuth.instance.currentUser!;
  UserModel get userData => Get.find<AuthController>().userData!;

  logout() => AuthController().logout();

  search() => Get.toNamed(AppRoutes.search);

  @override
  void onInit() async {
    super.onInit();
    print('${userData}');
  }
}
