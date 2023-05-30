
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/group_controller.dart';
import '../widget/group_tile.dart';

class SearchPage extends GetView<GroupController> {
  const SearchPage({Key? key}) : super(key: key);
  static const String route = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text('search'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8)
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: controller.searchController,
                      decoration: InputDecoration(
                        hintText: '그룹 검색',
                        border: InputBorder.none,
                        isCollapsed: true,
                      ),
                      onSubmitted: (String value) {
                        controller.searchGroup();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Obx(
            () => controller.resultList.value != null
              ? ListView.builder(
                shrinkWrap: true,
                itemCount: controller.resultList.value!.length,
                itemBuilder: (context, index) {
                  return GroupTile(group: controller.resultList.value![index]);
                }
              ) : Container()
          )
        ],
      ),
    );
  }
}

