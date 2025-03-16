import 'dart:async';

import 'package:uid_2fa/app/common/util/navigator.dart';
import 'package:uid_2fa/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uid_2fa/app/common/constants.dart';
import 'package:uid_2fa/app/common/util/exports.dart';
import 'package:uid_2fa/app/data/errors/api_error.dart';
import 'package:uid_2fa/app/data/interface_controller/api_interface_controller.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Extensions {}

extension BorderRadiusExt on num {
  BorderRadius get borderRadius => BorderRadius.circular(r);

  InputBorder outlineInputBorder({
    BorderSide borderSide = BorderSide.none,
  }) =>
      OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: borderSide,
      );

  BorderSide borderSide({
    Color? color,
    double? width,
    BorderStyle? style,
  }) =>
      BorderSide(
        color: color ?? Colors.white,
        width: 0.5,
        style: style ?? BorderStyle.solid,
      );
}

BoxShadow get boxShadow => BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      spreadRadius: 3,
      blurRadius: 4,
      offset: const Offset(0, 3), // changes position of shadow
    );
BoxDecoration get borderService => BoxDecoration(
    border: Border.all(color: AppColors.kBlackBorder, width: 0.5),
    borderRadius: 5.borderRadius);

extension HexColorExt on String {
  Color get fromHex {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) {
      buffer.write('ff');
    }

    if (startsWith('#')) {
      buffer.write(replaceFirst('#', ''));
    }
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension DateTimeFormatterExt on DateTime {
  String formatedDate({
    String dateFormat = 'yyyy-MM-dd',
  }) {
    final formatter = DateFormat(dateFormat);
    return formatter.format(this);
  }
}

extension TimeOfDayExt on String {
  TimeOfDay getTimeOfDay({
    int addMinutes = 0,
  }) =>
      TimeOfDay.fromDateTime(
        DateFormat.jm().parse(this).add(
              Duration(
                minutes: addMinutes,
              ),
            ),
      );
}

extension ImageExt on String {
  String get image => 'assets/images/$this.png';

  Image imageAsset({
    Size? size,
    BoxFit? fit,
    Color? color,
  }) =>
      Image.asset(
        this,
        color: color,
        width: size?.width,
        height: size?.height,
        fit: fit,
      );
}

extension FutureExt<T> on Future<Response<T>?> {
  void futureValue(
    Function(T value) response, {
    required Function(String? error)? onError,
  }) {
    final interface = Get.find<ApiInterfaceController>();
    interface.error = null;

    timeout(
      Constants.timeout,
      onTimeout: () {
        Utils.closeDialog();

        Utils.showSnackbar(
            message: Strings.noConnection, colors: AppColors.amaranth);

        throw ApiError(
          type: ErrorType.connectTimeout,
          error: Strings.noConnection,
        );
      },
    ).then((value) {
      Utils.closeDialog();
      if (value?.body != null) {
        response(value!.body as T);
      } else if (value?.status.connectionError ?? false) {
        throw ApiError(
          type: ErrorType.connectTimeout,
          error: Strings.noConnection,
        );
      } else {
        throw ApiError(
          type: ErrorType.connectTimeout,
          error: Strings.unknownError,
        );
      }
      interface.update();
    }).catchError((e) {
      if (e == null) return;
      String errorMessage = "";
      if (e is ApiError) {
        errorMessage = e.message;
      } else {
        errorMessage = e.toString();
      }

      if (e is ApiError) {
        if ((e.type == ErrorType.connectTimeout ||
            e.type == ErrorType.noConnection)) {
          interface.error = e;
        }
      }

      if (onError != null) {
        onError(errorMessage);
      }

      printError(info: 'catchError: error: $e\nerrorMessage: $errorMessage');
    });
  }
}

extension AlignWidgetExt on Widget {
  Widget align({
    Alignment alignment = Alignment.center,
  }) =>
      Align(
        alignment: alignment,
        child: this,
      );
}

extension FormatDurationExt on int {
  String formatDuration() {
    final min = this ~/ 60;
    final sec = this % 60;
    return "${min.toString().padLeft(2, "0")}:${sec.toString().padLeft(2, "0")} min";
  }
}

extension DebugLog on String {
  void debugLog() {
    return debugPrint(
      '\n******************************* DebugLog *******************************\n'
      ' $this'
      '\n******************************* DebugLog *******************************\n',
      wrapWidth: 1024,
    );
  }
}
