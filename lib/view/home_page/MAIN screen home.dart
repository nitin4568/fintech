import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resource/components/home/navbar_bottem.dart';
import '../../view_models/controller/home_controller/app_vs.dart';

import 'home_Page.dart';
import 'Insights Screen.dart';
import 'Goal Screen.dart';
import 'profile.dart';

class MainScreen extends StatelessWidget {
  final AppVM vm = Get.put(AppVM());

  MainScreen({super.key});

  final List<Widget> screens = [
    HomeScreen(),
    InsightsScreen(),
    GoalScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        body: IndexedStack(
          index: vm.selectedIndex.value,
          children: screens,
        ),

        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: CustomBottomNav(
              currentIndex: vm.selectedIndex.value,
              onTap: vm.changeIndex,
            ),
          ),
        ),
      );
    });
  }
}