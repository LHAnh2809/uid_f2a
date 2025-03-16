import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/util/exports.dart';

class TextFormWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final RxBool obscureText;
  final Function() togglePasswordVisibility;
  final Function(String) onChanged;
  final bool? showButton; // Thay đổi kiểu dữ liệu thành bool?
  final Widget? suffixIcon;
  final int? height;

  const TextFormWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.textInputType,
    required this.obscureText,
    required this.togglePasswordVisibility,
    required this.showButton,
    required this.onChanged,
    this.suffixIcon,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height == null ? 45.h : height!.h,
      padding: const EdgeInsets.only(top: 3, left: 15).r,
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
              padding: EdgeInsets.only(
                  right: showButton != null && showButton! ? 40 : 0),
              child: TextFormField(
                controller: controller,
                keyboardType: textInputType,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(0).r,
                  hintStyle: TextStyle(
                    height: 1,
                    color: Colors.grey, // Thay đổi màu chữ hintText
                    fontSize: 14.sp, // Kích thước chữ
                    fontWeight: FontWeight.w100, // Độ đậm của chữ
                  ),
                ),
              ),
            ),
            if (showButton != null && showButton!)
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: togglePasswordVisibility,
                icon: Icon(
                  obscureText.value ? Icons.paste : Icons.close,
                  color: Colors.grey,
                ),
              )
          ],
        ),
      ),
    );
  }
}
