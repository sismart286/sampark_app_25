import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sampark_app_25/Model/ChatRoomModel.dart';
import 'package:sampark_app_25/Model/UserModel.dart';

class ContactController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  RxList<UserModel> usersList = <UserModel>[].obs;
  RxList<ChatRoomModel> chatRoomList = <ChatRoomModel>[].obs;

  void onInit() async {
    super.onInit();
    await getUserList();
    await getChatRoomList();
  }

  Future<void> getUserList() async {
    isLoading.value = true;
    try {
      usersList.clear();
      await db.collection("users").get().then(
            (value) => {
              usersList.value = value.docs
                  .map(
                    (e) => UserModel.fromJson(e.data()),
                  )
                  .toList()
            },
          );
    } catch (ex) {
      log("ex: $ex");
    }
    isLoading.value = true;
  }

  Future<void> getChatRoomList() async {
    List<ChatRoomModel> tempChatRoom = [];
    await db
        .collection('chats')
        .orderBy("timestamp", descending: true)
        .get()
        .then(
      (value) {
        tempChatRoom = value.docs
            .map(
              (e) => ChatRoomModel.fromJson(e.data()),
            )
            .toList();
      },
    );
    chatRoomList.value = tempChatRoom
        .where(
          (e) => e.id!.contains(
            auth.currentUser!.uid,
          ),
        )
        .toList();

    print("chatRoomList: $chatRoomList");
  }

  Future<void> saveContact(UserModel user) async {
    try {
      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("contacts")
          .doc(user.id)
          .set(user.toJson());
    } catch (ex) {
      if (kDebugMode) {
        log("Error while saving Contacts $ex");
      }
    }
  }

  Stream<List<UserModel>> getContacts() {
    return db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("contacts")
        .snapshots()
        .map(
          (snashot) => snashot.docs
              .map(
                (doc) => UserModel.fromJson(doc.data()),
              )
              .toList(),
        );
  }
}
