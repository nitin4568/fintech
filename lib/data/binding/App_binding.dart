import 'package:get/get.dart';
import '../../view_models/controller/home_controller/home_controller.dart';
import '../../view_models/controller/home_controller/app_vs.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {


    Get.put<AppVM>(
      AppVM(),
      permanent: true,
    );

    Get.put<HomeVM>(
      HomeVM(),
      permanent: true,
    );
  }
}