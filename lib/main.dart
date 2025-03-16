import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uid_2fa/theme_controller.dart';

import 'app/common/util/exports.dart';
import 'app/common/util/initializer.dart';
import 'app/routes/app_pages.dart';

void main() {
  Initializer.instance.init(() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final ThemeController themeController = Get.put(ThemeController());
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      builder: (context, widget) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: AppTheme.theme,
        defaultTransition: Transition.fadeIn,
        initialRoute: Routes.home,
        getPages: AppPages.routes,
        initialBinding: InitialBindings(),
        darkTheme: AppTheme.darkTheme,
        themeMode:
            themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      ),
    );
  }
}
