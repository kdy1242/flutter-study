
import 'dart:developer';

import 'package:chat_app/controller/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/group.dart';
import '../model/message.dart';
import '../model/user.dart';
import '../service/db_service.dart';

class ChatController extends GetxController {
  Group group = Get.arguments[0];
  TextEditingController messageController = TextEditingController();
  RxList chats = [].obs;
  User user = FirebaseAuth.instance.currentUser!;
  ScrollController scrollController = ScrollController();

  UserModel get userData => Get.find<AuthController>().userData!;

  @override
  void onInit() {
    super.onInit();
    log('chat group => ${group.groupName}');
    // Firestore 컬렉션의 스트림을 구독하여 chats 리스트 갱신
    FirebaseFirestore.instance
        .collection('groups')
        .doc(group.groupId)
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        chats(snapshot.docs.map((doc) => Message.fromMap(doc.data() as Map<String, dynamic>)).toList());
      } else {
        chats([]);
      }
      update(); // GetX에게 상태 업데이트를 알림
      log('chats => ${chats}');
    });

    ever(chats, (_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    });
  }

  void sendMessage(String groupId) {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": userData.name,
        "time": DateTime.now(),
      };

      DBService().sendMessage(groupId, chatMessageMap);
      messageController.clear();
    }
  }

  bool sentByMe(String sender) {
    try {
      return userData.name == sender;
    } catch (e) {
      return false;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
