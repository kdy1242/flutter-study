
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/db_service.dart';

class ChatController extends GetxController {
  late String? groupId;
  late String groupName;
  late String userName;
  // Rx<Stream<QuerySnapshot>?> chats = Rx<Stream<QuerySnapshot>?>(null);
  TextEditingController messageController = TextEditingController();
  RxString admin = RxString('');
  RxList<DocumentSnapshot> chats = <DocumentSnapshot>[].obs;

  ChatController({this.groupId});

  @override
  void onInit() {
    super.onInit();
    // Firestore 컬렉션의 스트림을 구독하여 chats 리스트 갱신
    FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        chats = snapshot.docs.obs;
      } else {
        chats = <DocumentSnapshot>[].obs;
      }
      update(); // GetX에게 상태 업데이트를 알림
      log('chats: ${chats}');
    });
  }

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": userName,
        "time": DateTime.now(),
      };

      DBService().sendMessage(groupId!, chatMessageMap);
      messageController.clear();
    }
  }
}
