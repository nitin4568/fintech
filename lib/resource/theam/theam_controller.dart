import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  final box = GetStorage();

  var isDark = false.obs;

  @override
  void onInit() {
    isDark.value = box.read('darkMode') ?? false;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
    super.onInit();
  }

  void toggleTheme(bool value) {
    isDark.value = value;
    box.write('darkMode', value);

    Get.changeThemeMode(
        value ? ThemeMode.dark : ThemeMode.light);
  }
}