import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:uid_2fa/app/common/util/exports.dart';
import 'package:uid_2fa/app/modules/home/controllers/home_controller.dart';

import '../../../../theme_controller.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_form_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          Obx(() => IconButton(
                icon: Icon(themeController.isDarkMode.value
                    ? Icons.dark_mode
                    : Icons.light_mode),
                onPressed: themeController.toggleTheme,
              )),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  'Lấy UID Facebook',
                  style: AppTextStyle.largeBodyStyle.copyWith(
                    color: themeController.isDarkMode.value
                        ? AppColors.white
                        : AppColors.kGray1000Color,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              TextFormWidget(
                hintText: 'Nhập Link Facebook cần lấy UID',
                textInputType: TextInputType.text,
                obscureText: controller.isUID,
                togglePasswordVisibility: () {
                  controller.pasteFromClipboard(
                      controller.uIDController, controller.isUID);
                },
                showButton: true,
                onChanged: (event) {
                  controller.isUID.value =
                      controller.uIDController.text.isEmpty;
                  if (controller.uIDController.text.isEmpty) {
                    controller.uidDataUID.value = "";
                  }
                },
                controller: controller.uIDController,
              ),
              Obx(
                () => controller.uidDataUID.value.isEmpty
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          SizedBox(height: 10.h),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () => controller
                                .copyToClipboard(controller.uidDataUID.value),
                            child: IntrinsicWidth(
                              child: Row(
                                children: [
                                  Text(
                                    controller.uidDataUID.value,
                                    style: AppTextStyle.textsmallStyle.copyWith(
                                      color: themeController.isDarkMode.value
                                          ? AppColors.white
                                          : AppColors.kGreenChart,
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Icon(
                                    Icons.copy,
                                    size: 18.sp,
                                    color: themeController.isDarkMode.value
                                        ? AppColors.white
                                        : AppColors.kGreenChart,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              SizedBox(height: 10.h),
              Obx(
                () => controller.isLoadingUID.value
                    ? Container(
                        alignment: Alignment.center,
                        height: 45.h,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8).r,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.kButtonColor.withOpacity(0.2),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: LoadingAnimationWidget.staggeredDotsWave(
                            color: AppColors.white, size: 30.r))
                    : ButtonWidget(
                        onTap: () => controller.fetchUID(),
                        text: 'Lấy UID',
                        width: double.infinity,
                        height: 40.h,
                        colorBackGroud: Colors.blue,
                      ),
              ),
              SizedBox(height: 10.h),
              Obx(
                () => Text(
                  'Mật khẩu',
                  style: AppTextStyle.largeBodyStyle.copyWith(
                    color: themeController.isDarkMode.value
                        ? AppColors.white
                        : AppColors.kGray1000Color,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              TextFormWidget(
                hintText: 'Mật khẩu',
                textInputType: TextInputType.text,
                obscureText: true.obs,
                togglePasswordVisibility: () {},
                showButton: false,
                onChanged: (event) {
                  controller.mk.value = controller.mkController.text;
                },
                controller: controller.mkController,
              ),
              SizedBox(height: 10.h),
              Obx(
                () => Text(
                  'Lấy code từ KEY 2FA',
                  style: AppTextStyle.largeBodyStyle.copyWith(
                    color: themeController.isDarkMode.value
                        ? AppColors.white
                        : AppColors.kGray1000Color,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                height: 120.h,
                padding: const EdgeInsets.only(top: 10, left: 15).r,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.1),
                      blurRadius: 7.r,
                    ),
                  ],
                ),
                child: Obx(
                  () => Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30).r,
                        child: TextFormField(
                          controller: controller.ma2faController,
                          keyboardType: TextInputType.text,
                          maxLines: null,
                          expands: true,
                          onChanged: (event) {
                            controller.is2FA.value =
                                controller.ma2faController.text.isEmpty;
                            controller.ma2fa.value =
                                controller.ma2faController.text;
                          },
                          decoration: InputDecoration(
                            hintText:
                                "Nhập Full KEY 2FA ở đây ... ¥NQV HJNP QCNP JJIY ... L2WA M4BZ RBM2 YVJP ...",
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(0).r,
                            hintStyle: TextStyle(
                              height: 1,
                              color: Colors.grey, // Thay đổi màu chữ hintText
                              fontSize: 14.sp, // Kích thước chữ
                              fontWeight: FontWeight.w400, // Độ đậm của chữ
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () => controller.pasteFromClipboard(
                            controller.ma2faController, controller.is2FA),
                        icon: Icon(
                          controller.is2FA.value ? Icons.paste : Icons.close,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Obx(
                () => controller.isLoading2FA.value
                    ? Container(
                        alignment: Alignment.center,
                        height: 45.h,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8).r,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.kButtonColor.withOpacity(0.2),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: LoadingAnimationWidget.staggeredDotsWave(
                            color: AppColors.white, size: 30.r))
                    : ButtonWidget(
                        onTap: () => controller.getOTP(),
                        text: 'Lấy Code',
                        width: double.infinity,
                        height: 40.h,
                        colorBackGroud: Colors.blue,
                      ),
              ),
              SizedBox(height: 10.h),
              Obx(
                () => controller.otpCode.value.isEmpty
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Mã Code',
                                style: AppTextStyle.lableBodyStyle.copyWith(
                                  color: themeController.isDarkMode.value
                                      ? AppColors.white
                                      : AppColors.kGray1000Color,
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () => controller
                                    .copyToClipboard(controller.otpCode.value),
                                child: IntrinsicWidth(
                                  child: Row(
                                    children: [
                                      Text(
                                        controller.otpCode.value,
                                        style: AppTextStyle.textsmallStyle
                                            .copyWith(
                                          color:
                                              themeController.isDarkMode.value
                                                  ? AppColors.kYellowColor
                                                  : AppColors.kGreenChart,
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Icon(
                                        Icons.copy,
                                        size: 18.sp,
                                        color: themeController.isDarkMode.value
                                            ? AppColors.kYellowColor
                                            : AppColors.kGreenChart,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Thời gian',
                                style: AppTextStyle.lableBodyStyle.copyWith(
                                  color: themeController.isDarkMode.value
                                      ? AppColors.white
                                      : AppColors.kGray1000Color,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    size: 18.sp,
                                    color: themeController.isDarkMode.value
                                        ? AppColors.kGreenText
                                        : AppColors.kRrror600Color,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    controller.countdown.value.toString(),
                                    style: AppTextStyle.textsmallStyle.copyWith(
                                      color: themeController.isDarkMode.value
                                          ? AppColors.kGreenText
                                          : AppColors.kRrror600Color,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
              ),
              Obx(
                () {
                  // Check if any of the reactive text values are empty
                  bool isAnyFieldEmpty = controller.uidDataUID.value.isEmpty ||
                      controller.mk.value.isEmpty ||
                      controller.ma2fa.value.isEmpty;

                  return isAnyFieldEmpty
                      ? const SizedBox.shrink()
                      : ButtonWidget(
                          onTap: () => controller.copyToClipboard(
                              '${controller.uidDataUID.value}|${controller.mk.value}|${controller.ma2fa.value}'), // Use reactive variables here
                          widget: IntrinsicWidth(
                            child: Row(
                              children: [
                                Text(
                                  '${controller.uidDataUID.value}|${controller.mk.value}|${controller.ma2fa.value}', // Use reactive variables here
                                  style: AppTextStyle.textsmallStyle.copyWith(
                                    color: themeController.isDarkMode.value
                                        ? AppColors.kYellowColor
                                        : AppColors.kGreenChart,
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Icon(
                                  Icons.copy,
                                  size: 18.sp,
                                  color: themeController.isDarkMode.value
                                      ? AppColors.kYellowColor
                                      : AppColors.kGreenChart,
                                ),
                              ],
                            ),
                          ),
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
