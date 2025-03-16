import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otp/otp.dart';
import 'package:uid_2fa/app/data/repository/api_helper_impl.dart';

import '../../../common/util/exports.dart';
import '../../../data/repository/api_helper.dart';

class HomeController extends GetxController {
  final ApiHelper apiHelper = ApiHelperImpl();

  final uIDController = TextEditingController();
  final ma2faController = TextEditingController();

  var isUID = true.obs;
  var isLoadingUID = false.obs;
  var uidDataUID = "".obs;

  var is2FA = true.obs;
  var otpCode = "".obs;
  var isLoading2FA = false.obs;

  var countdown = 30.obs;
  Timer? timer;

  Future<void> fetchUID() async {
    final link = uIDController.text.trim();
    if (link.isEmpty) {
      Utils.showSnackbar(
          message: 'Vui lòng nhập link!',
          icon: "assets/icons/circle_check_24px.svg",
          colors: AppColors.kRrror600Color);
      return;
    }

    try {
      isLoadingUID.value = true;
      final result = await apiHelper.getUID(link: link);
      if (result["code"] == 200) {
        uidDataUID.value = result["id"];
        Utils.showSnackbar(
            message: 'Lấy ID thành công',
            icon: "assets/icons/circle_check_24px.svg",
            colors: AppColors.kSuccess600Color);
        return;
      } else if (result["code"] == 400) {
        Utils.showSnackbar(
            message: 'Link không hợp lệ!',
            icon: "assets/icons/circle_check_24px.svg",
            colors: AppColors.kRrror600Color);
        return;
      }
    } catch (e) {
      Utils.showSnackbar(
          message: 'Không thể lấy UID: $e',
          icon: "assets/icons/circle_check_24px.svg",
          colors: AppColors.kRrror600Color);
    } finally {
      isLoadingUID.value = false;
    }
  }

  void copyToClipboard(String controller) {
    if (controller.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: controller));
      Utils.showSnackbar(
          message: 'Sao chép thành công',
          icon: "assets/icons/circle_check_24px.svg",
          colors: AppColors.kSuccess600Color);
    }
  }

  Future<void> pasteFromClipboard(
      TextEditingController controller, RxBool state) async {
    if (state.value) {
      ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
      if (data != null) {
        controller.text = data.text ?? "";
      }
    } else {
      controller.clear();
      uidDataUID.value = "";
    }
    state.value = controller.text.isEmpty;
  }

  String removeSpaces(String input) {
    return input.replaceAll(RegExp(r'\s+'), '');
  }

  Future<void> getOTP() async {
    try {
      final key = ma2faController.text.trim();
      if (key.isEmpty) {
        Utils.showSnackbar(
            message: 'Vui lòng nhập key!',
            icon: "assets/icons/circle_check_24px.svg",
            colors: AppColors.kRrror600Color);
        return;
      }
      isLoading2FA.value = true;
      otpCode.value = await OTP.generateTOTPCodeString(
        removeSpaces(key),
        DateTime.now().millisecondsSinceEpoch,
        interval: 30, // Thời gian mã OTP hợp lệ (mặc định 30 giây)
        length: 6, // Độ dài mã OTP (thường là 6)
        algorithm:
            Algorithm.SHA1, // Thuật toán SHA1 (giống Google Authenticator)
        isGoogle: true,
      );
      isLoading2FA.value = false;
      countdown.value = 30;
      startCountdown();
      print("OTP: " + otpCode.value);
      Utils.showSnackbar(
          message: 'Lấy 2FA thành công',
          icon: "assets/icons/circle_check_24px.svg",
          colors: AppColors.kSuccess600Color);
    } catch (e) {
      Utils.showSnackbar(
          message: 'Không thể lấy 2FA: $e',
          icon: "assets/icons/circle_check_24px.svg",
          colors: AppColors.kRrror600Color);
    } finally {
      isLoading2FA.value = false;
    }
  }

  void startCountdown() {
    timer?.cancel(); // Hủy timer cũ nếu có
    countdown.value = 30; // Reset countdown về 30 giây

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        timer.cancel(); // Dừng timer khi hết thời gian
        if (ma2faController.text.trim().isNotEmpty) {
          getOTP(); // Lấy OTP mới sau khi hết thời gian
        } else {
          countdown.value = 0;
        }
      }
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
