import 'package:get/get.dart';
import 'package:uid_2fa/app/modules/home/views/home_page.dart';

import '../modules/home/bindings/home_binding.dart';

part 'app_routes.dart';

class AppPages {
  const AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.home,
      transition: Transition.rightToLeftWithFade,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
