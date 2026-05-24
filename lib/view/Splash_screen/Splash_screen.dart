import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resource/routes/routs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    initApp();
  }

  Future<void> initApp() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offAllNamed(AppRouteNames.main);
  }
  //splash code

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
              const Color(0xFF0F172A),
              const Color(0xFF020617),
            ]
                : [
              const Color(0xFFEFF6FF),
              Colors.white,
              const Color(0xFFDBEAFE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Lottie.asset(
                "assets/Manage Money.json",
                width: 200.w,
                height: 200.h,
                fit: BoxFit.contain,
              ),

              SizedBox(height: 20.h),

              Text(
                "Ethereal Vault",
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3B82F6),
                ),
              ),

              SizedBox(height: 8.h),

              Text(
                "Track. Save. Grow.",
                style: TextStyle(
                  color: textColor.withOpacity(0.7),
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
