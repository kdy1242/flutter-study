
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/chat_controller.dart';
import '../../model/group.dart';
import '../../service/db_service.dart';
import '../widget/message_tile.dart';
import 'group_info_page.dart';

class ChatPage extends GetView<ChatController> {
  ChatPage(this.group, {Key? key}) : super(key: key);
  final Group group;
  static const String route = '/chat';

  @override
  Widget build(BuildContext context) {
    Get.put(ChatController(groupId: group.groupId)); // ChatController를 주입
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(group.groupName),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => GroupInfoPage(group));
            },
            icon: const Icon(Icons.info),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          // chat messages here
          Obx(
            () => ListView.builder(
              itemCount: controller.chats.length,
              itemBuilder: (context, index) {
                var chat = controller.chats[index].data();
                log('${chat}');
                log('chats: ${controller.chats}');
                return Container();
              },
            )
          ),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              width: MediaQuery.of(context).size.width,
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
                    controller.sendMessage(group.groupId);
                    if (controller.messageController.text.isNotEmpty) {
                      Map<String, dynamic> chatMessageMap = {
                        "message": controller.messageController.text,
                        "sender": controller.userData.name,
                        "time": DateTime.now(),
                      };

                      DBService().sendMessage(group.groupId, chatMessageMap);
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

  // Widget chatMessages() {
  //   return Obx(
  //     () => StreamBuilder(
  //       stream: controller.chats.value,
  //       builder: (context, AsyncSnapshot snapshot) {
  //         return snapshot.hasData
  //         ? ListView.builder(
  //           itemCount: snapshot.data.docs.length,
  //           itemBuilder: (context, index) {
  //             return MessageTile(
  //               message: snapshot.data.docs[index]['message'],
  //               sender: snapshot.data.docs[index]['sender'],
  //               sentByMe: userName == snapshot.data.docs[index]['sender'],
  //             );
  //           },
  //         )
  //             : Container();
  //       },
  //     ),
  //   );
  // }
}
