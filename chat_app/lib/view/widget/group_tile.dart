
import 'package:chat_app/view/page/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/group.dart';
import '../../util/app_routes.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({Key? key, required this.group}) : super(key: key);
  final Group group;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.chat, arguments: [group]);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              group.groupName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          title: Text(
            group.groupName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "${group.recentMessage}",
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}

