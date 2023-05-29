
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';


class MainController extends GetxController {
  User get user => FirebaseAuth.instance.currentUser!;

  logout() => AuthController().logout();
}
