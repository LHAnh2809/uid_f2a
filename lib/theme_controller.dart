import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/common/storage/storage.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;
  final _key = 'isDarkMode';

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = _loadThemeFromStorage();
    Get.changeTheme(isDarkMode.value ? ThemeData.dark() : ThemeData.light());
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(isDarkMode.value ? ThemeData.dark() : ThemeData.light());
    _saveThemeToStorage(isDarkMode.value);
  }

  bool _loadThemeFromStorage() => Storage.getValue<bool>(_key) ?? false;

  void _saveThemeToStorage(bool isDarkMode) =>
      Storage.saveValue(_key, isDarkMode);
}
