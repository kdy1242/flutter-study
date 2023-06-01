
import 'dart:developer';

import 'package:chat_app/model/user.dart';
import 'package:chat_app/util/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/group_controller.dart';
import '../../model/group.dart';
import '../../service/db_service.dart';

class GroupInfoPage extends GetView<GroupController> {
  const GroupInfoPage(this.group, {Key? key}) : super(key: key);
  final Group group;

  @override
  Widget build(BuildContext context) {
    log('${group.members}');

    controller.getUser(group.members[0]);

    var admin;
    var users = [];

    Future getData() async {
      admin = await controller.getUser(group.admin);
      var userList = [];
      for (var userId in group.members) {
        userList.add(await controller.getUser(userId));
      }
      users = userList;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Group Info"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Exit"),
                    content:
                    Text('${group.groupName}을 나가시겠습니까?'),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          DBService(uid: controller.user!.uid)
                            .toggleGroupJoin(group.groupId)
                            .whenComplete(() {
                              Get.toNamed(AppRoutes.main);
                            });
                        },
                        icon: const Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  );
                });
            },
            icon: const Icon(Icons.exit_to_app)
          )
        ],
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).primaryColor.withOpacity(0.2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text(
                            group.groupName.substring(0, 1).toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Group: ${group.groupName}",
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("Admin: ${admin['name']}")
                          ],
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                    itemCount: users.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Text(
                              users[index]['name']
                                  .substring(0, 1)
                                  .toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(users[index]['name']),
                          subtitle: Text(users[index]['email']),
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          }
        }
      ),
    );
  }
}

