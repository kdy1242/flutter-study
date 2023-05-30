
import 'dart:developer';

import 'package:chat_app/model/user.dart';
import 'package:chat_app/util/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/group.dart';
import '../service/db_service.dart';
import 'auth_controller.dart';

class MainController extends GetxController {
  User get user => FirebaseAuth.instance.currentUser!;
  UserModel get userData => Get.find<AuthController>().userData!;
  TextEditingController createGroupController = TextEditingController();
  RxList groupList = [].obs;

  logout() => AuthController().logout();

  search() => Get.toNamed(AppRoutes.search);


  getUserGroup() async {
    var groupIdList = await DBService(uid: user.uid).getUserGroups();
    log('groupIdList ${groupIdList}');
    if (groupIdList.length > 0) {
      for (var groupId in groupIdList) {
        var mapGroup = await DBService().getGroupById(groupId);
        log('mapGroup ${mapGroup.data()}');
        groupList.add(Group.fromMap(mapGroup.data()));
      }
      log('groupList ${groupList}');
    }
  }

  createGroup() async {
    await DBService(uid: user.uid).createGroup(createGroupController.text);
    Get.back();
    Get.snackbar(
      '그룹 생성',
      '그룹이 성공적으로 생성되었습니다.',
    );
    getUserGroup();
  }

  @override
  void onInit() async {
    super.onInit();
    await getUserGroup();
    print('${userData}');
  }
}
