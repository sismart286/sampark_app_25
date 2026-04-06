import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app_25/Config/Strings.dart';
import 'package:sampark_app_25/Controller/ChatController.dart';
import 'package:sampark_app_25/Controller/ProfileController.dart';
import 'package:sampark_app_25/Model/UserModel.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallPage extends StatelessWidget {
  final UserModel target;
  const VideoCallPage({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    ChatController chatController = Get.put(ChatController());
    var callId = chatController.getRoomId(target.id!);

    return ZegoUIKitPrebuiltCall(
      appID: ZegoCloudConfig.appId, // your AppID,
      appSign: ZegoCloudConfig.appSign,
      userID: profileController.currentUser.value.id ?? "root",
      userName: profileController.currentUser.value.name ?? "root",
      callID: callId,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
