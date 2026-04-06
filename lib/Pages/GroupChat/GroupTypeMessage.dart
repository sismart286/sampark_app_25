import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sampark_app_25/Config/Images.dart';
import 'package:sampark_app_25/Controller/ChatController.dart';
import 'package:sampark_app_25/Controller/GroupController.dart';
import 'package:sampark_app_25/Controller/ImagePicker.dart';
import 'package:sampark_app_25/Model/GroupModel.dart';
import 'package:sampark_app_25/Model/UserModel.dart';
import 'package:sampark_app_25/Widgets/ImagePickerBottomSheet.dart';

class GroupTypeMessage extends StatelessWidget {
  final GroupModel groupModel;
  const GroupTypeMessage({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    RxString message = "".obs;
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    GroupController groupController = Get.put(GroupController());

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            child: SvgPicture.asset(
              AssetsImage.chatEmoji,
              width: 25,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: (value) {
                message.value = value;
              },
              controller: messageController,
              decoration: const InputDecoration(
                  filled: false, hintText: "Type message..."),
            ),
          ),
          const SizedBox(width: 10),
          Obx(
            () => groupController.selectedImagePath.value == ""
                ? InkWell(
                    onTap: () async {
                      ImagePickerBottomSheet(
                          context,
                          groupController.selectedImagePath,
                          imagePickerController);
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset(
                        AssetsImage.chatGallarySvg,
                        width: 25,
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
          const SizedBox(width: 10),
          Obx(() => message.value != "" ||
                  groupController.selectedImagePath.value != ""
              ? InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    groupController.sendGroupMessage(
                      messageController.text,
                      groupModel.id!,
                      "",
                    );
                    messageController.clear();
                    message.value = "";
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    child: groupController.isLoading.value
                        ? const CircularProgressIndicator()
                        : SvgPicture.asset(
                            AssetsImage.chatSendSvg,
                            width: 25,
                          ),
                  ),
                )
              : Container(
                  width: 30,
                  height: 30,
                  child: SvgPicture.asset(
                    AssetsImage.chatMicSvg,
                    width: 25,
                  ),
                )),
        ],
      ),
    );
  }
}
