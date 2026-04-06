import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app_25/Config/Images.dart';
import 'package:sampark_app_25/Controller/GroupController.dart';
import 'package:sampark_app_25/Pages/GroupChat/GroupChat.dart';
import 'package:sampark_app_25/Pages/Home/Widget/ChatTile.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    return Obx(
      () => ListView(
        children: groupController.groupList
            .map(
              (group) => InkWell(
                onTap: () {
                  Get.to(GroupChatPage(groupModel: group));
                },
                child: ChatTile(
                  name: group.name!,
                  imageUrl: group.profileUrl == ""
                      ? AssetsImage.defaultProfileUrl
                      : group.profileUrl!,
                  lastChat: "Group Created",
                  lastTime: "Just Now",
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
