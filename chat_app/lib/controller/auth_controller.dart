
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/user.dart';
import '../service/db_service.dart';
import '../util/app_routes.dart';
import '../service/auth_service.dart';

class AuthController extends GetxController {
  final Rxn<User> user = Rxn<User>();
  UserModel? userData;

  // 로그인
  login(String id, String pw) => AuthService().login(id, pw);

  // 로그아웃
  logout() => AuthService().logout();

  // 회원가입
  signup(String name, String email, String pw) => AuthService().signup(name, email, pw);

  getUserData() async {
    var res = await DBService().gettingUserData(user.value!.email!);
    List<dynamic> snapshotData = res.docs.map((doc) => doc.data()).toList();
    print('${snapshotData.first}');
    userData = UserModel.fromMap(snapshotData.first);
  }

  @override
  onInit() {
    super.onInit();
    FirebaseAuth.instance.authStateChanges().listen((value) async {
      user(value);
      if (value != null) {
        // 유저가 있는 상태
        await getUserData();
        log('${userData}');
        Get.offAllNamed(AppRoutes.main);

      } else {
        // 유저가 없는 상태
        Get.offAllNamed(AppRoutes.login);
      }
    });
  }
}
