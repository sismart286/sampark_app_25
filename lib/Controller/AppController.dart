import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Appcontroller extends GetxController {
  RxString oldVersion = "".obs;
  RxString currentVersion = "".obs;
  RxString newAppUrl = "".obs;

  void onInit() async {
    super.onInit();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    currentVersion.value = packageInfo.version;
    log("currentVersion.value: ${currentVersion.value.toString()}");
    checkLatestVersion();
  }

  Future<void> checkLatestVersion() async {
    const repositoryOwner = 'sismart286';
    const repositoryName = 'Sampark';
    final response = await http.get(Uri.parse(
      "http://api.github.com/repos/$repositoryOwner/$repositoryName/releases/latest",
    ));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final tagName = data['tag_name'];
      oldVersion.value = tagName;
      final assets = data['assets'] as List<dynamic>;
      for (final asset in assets) {
        final assetName = asset['name'];
        final assetDownloadUrl = asset['browser_download_url'];
        newAppUrl.value = assetDownloadUrl;
      }
      checkUpdate();

      if (currentVersion.value != oldVersion.value) {
        checkUpdate();
      }
    } else {
      log("Failed to fetch Github release info, Status code: ${response.statusCode}");
    }
  }

  void checkUpdate() {
    Get.rawSnackbar(
      message: "New Update Available",
      mainButton: TextButton(
        onPressed: () {
          launchUrl(
            Uri.parse(newAppUrl.value),
            mode: LaunchMode.externalApplication,
          );
          Get.back();
        },
        child: Text("Update"),
      ),
      duration: Duration(days: 1),
      icon: Icon(Icons.update_sharp),
      snackStyle: SnackStyle.FLOATING,
      barBlur: 20,
      leftBarIndicatorColor: Colors.blue,
    );
  }
}
