
import 'dart:developer';

import 'package:chat_app/model/group.dart';
import 'package:chat_app/service/db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GroupController extends GetxController {
  TextEditingController searchController = TextEditingController();
  Rxn<List> resultList = Rxn();
  RxBool isJoined = false.obs;
  User? user = FirebaseAuth.instance.currentUser;

  searchGroup() async {
    var res = await DBService().searchByName(searchController.text);
    List<dynamic> snapshotData = res.docs.map((doc) => doc.data()).toList();
    resultList(snapshotData.map((e) => Group.fromMap(e)).toList());
    log('${snapshotData}');
    log('resultList = ${resultList}');
  }

  joinedOrNot(String groupId) async {
    await DBService(uid: user!.uid)
        .isUserJoined(groupId)
        .then((value) {
      isJoined(value);
    });
  }

  getUser(String uid) async {
    var res = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    log('res = ${res.data()}');
    return res.data();
  }

  // onTapJoin() async {
  //   await DBService(uid: user!.uid).toggleGroupJoin(group.groupId);
  //   if (isJoined) {
  //     setState(() {
  //       isJoined = !isJoined;
  //     });
  //     showSnackbar(context, Colors.green, "Successfully joined he group");
  //     Future.delayed(const Duration(seconds: 2), () {
  //       // 페이지 이동 (채팅페이지)
  //     });
  //   } else {
  //     setState(() {
  //       isJoined = !isJoined;
  //       showSnackbar(context, Colors.red, "Left the group $groupName");
  //     });
  //   }
  // }
}
