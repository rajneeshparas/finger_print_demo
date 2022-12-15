import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/common_strings.dart';

class UserSession extends GetxController {
  var isFingerPrintEnable = false.obs;
  var isFingerPDisable = false.obs;
  final box = GetStorage();

  init() {
    isFingerPrintEnable.value = box.read(isFingerPrintEnableString) ?? false;
    isFingerPDisable.value = box.read(isFingerPDisableString) ?? true;
  }

  setIsFingerPrintEnable(bool value) {
    isFingerPrintEnable.value = value;
    setToBox(isFingerPrintEnableString, value);
  }

  setIsFingerPDisable(bool value) {
    isFingerPDisable.value = value;
    setToBox(isFingerPDisableString, value);
  }

  setToBox(String key, dynamic value) {
    box.write(key, value);
  }
}
