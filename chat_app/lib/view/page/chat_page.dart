
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/chat_controller.dart';
import '../../model/message.dart';
import '../../service/db_service.dart';
import '../widget/message_tile.dart';
import 'group_info_page.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({Key? key}) : super(key: key);
  static const String route = '/chat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(controller.group.groupName),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => GroupInfoPage(controller.group));
            },
            icon: const Icon(Icons.info),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          // chat messages here
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: controller.chats.length,
                itemBuilder: (context, index) {
                  Message chat = controller.chats[index];
                  bool sentByMe = controller.sentByMe(chat.sender);
                  return MessageTile(message: chat, sentByMe: sentByMe);
                },
              ),
            )
          ),
          Container(
            alignment: Alignment.bottomCenter,
            width: Get.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              width: Get.width,
              color: Colors.grey[700],
              child: Row(children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Send a message...",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () {
                    controller.sendMessage(controller.group.groupId);
                    if (controller.messageController.text.isNotEmpty) {
                      Map<String, dynamic> chatMessageMap = {
                        "message": controller.messageController.text,
                        "sender": controller.userData.name,
                        "time": DateTime.now(),
                      };
                      DBService().sendMessage(controller.group.groupId, chatMessageMap);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
