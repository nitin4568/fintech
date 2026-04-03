import 'package:get/get.dart';
import '../../view_models/controller/home_controller/home_controller.dart';
import '../../view_models/controller/home_controller/app_vs.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {

    /// 🔥 NAVIGATION CONTROLLER (GLOBAL)
    Get.put<AppVM>(
      AppVM(),
      permanent: true,
    );

    /// 💰 HOME / TRANSACTION CONTROLLER
    Get.put<HomeVM>(
      HomeVM(),
      permanent: true,
    );
  }
}