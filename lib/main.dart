import 'package:bankapp/resource/theam/theam.dart';
import 'package:bankapp/resource/theam/theam_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'resource/routes/App_routes.dart';
import 'resource/routes/routs.dart';
import 'data/binding/App_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // 🔥 storage init

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) {
        return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,

          initialBinding: AppBinding(),
          initialRoute: AppRouteNames.splash,
          getPages: AppRoutes.routes,

          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,


          themeMode: themeController.isDark.value
              ? ThemeMode.dark
              : ThemeMode.light,
        ));
      },
    );
  }
}