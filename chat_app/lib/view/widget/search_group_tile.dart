
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/group.dart';
import '../../service/db_service.dart';

class SearchGroupTile extends StatelessWidget {
  const SearchGroupTile({Key? key, required this.group}) : super(key: key);
  final Group group;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Theme.of(context).primaryColor,
        child: Text(
          group.groupName.substring(0, 1).toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title:
      Text(group.groupName, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text("Admin: ${group.admin}"),
      trailing: InkWell(
        onTap: () async {
          await DBService(uid: FirebaseAuth.instance.currentUser!.uid).toggleGroupJoin(group.groupId);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
            border: Border.all(color: Colors.white, width: 1),
          ),
          padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: const Text(
            "Join",
            style: TextStyle(color: Colors.white),
          ),
        )
      ),
    );
  }
}

