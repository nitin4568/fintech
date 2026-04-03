import 'package:get/get.dart';
import 'package:bankapp/resource/routes/routs.dart';

import '../../view/Splash_screen/Splash_screen.dart';
/// 🔥 Screens import
import '../../view/home_page/MAIN screen home.dart';
import '../../view/home_page/home_Page.dart';
import '../../view/home_page/Insights Screen.dart';
import '../../view/home_page/Goal Screen.dart';

import '../../view/home_page/Transaction History Screen.dart';
import '../../view/home_page/Add Transaction Screen.dart';
import '../../view/home_page/profile.dart';

class AppRoutes {
  static final routes = [

    /// Splash
    GetPage(
      name: AppRouteNames.splash,
      page: () => SplashScreen(),
    ),

    /// Main (Bottom Nav container)
    GetPage(
      name: AppRouteNames.main,
      page: () => MainScreen(),
    ),

    /// Bottom Nav Screens
    GetPage(
      name: AppRouteNames.home,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: AppRouteNames.insights,
      page: () => InsightsScreen(),
    ),
    GetPage(
      name: AppRouteNames.goals,
      page: () => GoalScreen(),
    ),
    GetPage(
      name: AppRouteNames.profile,
      page: () => ProfileScreen(),
    ),

    /// Extra Screens
    GetPage(
      name: AppRouteNames.transactions,
      page: () => TransactionScreen(),
    ),
    GetPage(
      name: AppRouteNames.addTransaction,
      page: () => AddTransactionScreen(),
    ),
  ];
}