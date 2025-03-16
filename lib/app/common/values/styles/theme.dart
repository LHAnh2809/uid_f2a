import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uid_2fa/app/common/util/extensions.dart';
import 'package:uid_2fa/app/common/values/app_colors.dart';
import 'package:uid_2fa/app/common/values/styles/app_text_style.dart';
import 'package:uid_2fa/app/common/values/styles/dimens.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get theme {
    final inputBorder = 20.outlineInputBorder(
      borderSide: 3.borderSide(),
    );

    return ThemeData(
      brightness: Brightness.light,
      unselectedWidgetColor: AppColors.kBlueLight,
      primaryColor: AppColors.kButtonColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: "Quicksand",
      appBarTheme: const AppBarTheme(
        color: AppColors.kPrimaryColor,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.kPrimaryColor,
        height: 45.h,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: 20.borderRadius,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith(
            (_) => EdgeInsets.zero,
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.white.withOpacity(.14);
              }

              return null;
            },
          ),
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (_) => AppTextStyle.buttonTextStyle,
          ),
          shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
            (states) => RoundedRectangleBorder(
              borderRadius: 20.borderRadius,
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return AppColors.doveGray;
              }
              return null;
            },
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith(
            (_) => EdgeInsets.zero,
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.white.withOpacity(.14);
              }

              return null;
            },
          ),
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (_) => AppTextStyle.buttonTextStyle,
          ),
          shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
            (states) => RoundedRectangleBorder(
              borderRadius: 20.borderRadius,
            ),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 4,
        backgroundColor: AppColors.kPrimaryColor,
      ),
      textTheme: TextTheme(
        titleMedium: AppTextStyle.regularStyle.copyWith(
          color: AppColors.black,
          fontSize: Dimens.fontSize14,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 3,
        ),
        enabledBorder: inputBorder,
        disabledBorder: inputBorder,
        focusedBorder: inputBorder,
        border: inputBorder,
      ),
      cardTheme: CardTheme(
        color: Colors.white.withOpacity(0.85),
        shape: RoundedRectangleBorder(
          borderRadius: 10.borderRadius,
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: 20.borderRadius,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(23.r),
            topRight: Radius.circular(23.r),
          ),
        ),
      ),

      // colorScheme: ColorScheme.fromSwatch(
      //   accentColor: Color.fromARGB(255, 255, 255, 255),
      //   primarySwatch: Colors.white,
      //   // primaryColorDark: Colors.red,
      // ),
    );
  }

  static ThemeData get darkTheme {
    final inputBorder = 20.outlineInputBorder(
      borderSide: 3.borderSide(color: Colors.white54),
    );

    return ThemeData(
      brightness: Brightness.dark,
      unselectedWidgetColor: Colors.grey,
      primaryColor: Colors.blueGrey,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: "Quicksand",
      appBarTheme: const AppBarTheme(
        color: Colors.black87,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blueGrey,
        height: 45.h,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: 20.borderRadius,
        ),
      ),
      textTheme: TextTheme(
        titleMedium: AppTextStyle.regularStyle.copyWith(
          color: Colors.white,
          fontSize: Dimens.fontSize14,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.black26,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 3,
        ),
        enabledBorder: inputBorder,
        disabledBorder: inputBorder,
        focusedBorder: inputBorder,
        border: inputBorder,
      ),
      cardTheme: CardTheme(
        color: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: 10.borderRadius,
        ),
      ),
    );
  }
}
