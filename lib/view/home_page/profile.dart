import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resource/theam/theam_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Profile",
          style: TextStyle(color: textColor, fontSize: 18.sp),
        ),
      ),

      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [

          /// 🔥 PROFILE CARD
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Row(
              children: [

                Container(
                  height: 60.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),

                SizedBox(width: 12.w),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Signup",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: textColor)),

                    SizedBox(height: 6.h),

                    Text("Create your account",
                        style: TextStyle(
                            color: textColor!.withOpacity(0.6))),
                  ],
                )
              ],
            ),
          ),

          SizedBox(height: 20.h),

          /// 🔹 APP PREFERENCES
          Text("APP PREFERENCES",
              style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold)),

          SizedBox(height: 10.h),

          /// 🌙 DARK MODE SWITCH
          Obx(() => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              children: [

                Icon(Icons.dark_mode, color: textColor),

                SizedBox(width: 12.w),

                Expanded(
                  child: Text("Dark appearance",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: textColor)),
                ),

                Switch(
                  value: themeController.isDark.value,
                  onChanged: (value) {
                    themeController.toggleTheme(value);
                  },
                )
              ],
            ),
          )),

          _tile(context, Icons.currency_rupee,
              "Primary currency", "INR (₹)"),

          _tile(context, Icons.language,
              "Language", "English"),

          SizedBox(height: 20.h),

          /// 🔹 SECURITY
          Text("SECURITY & ALERTS",
              style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold)),

          SizedBox(height: 10.h),

          _tile(context, Icons.notifications,
              "Smart notifications", "Coming soon"),

          _tile(context, Icons.lock,
              "Vault protection", "Coming soon"),
        ],
      ),
    );
  }

  /// 🔹 COMMON TILE
  Widget _tile(
      BuildContext context,
      IconData icon,
      String title,
      String subtitle,
      ) {
    final textColor =
        Theme.of(context).textTheme.bodyLarge!.color;

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [

          Icon(icon, color: textColor),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: textColor)),

                Text(subtitle,
                    style: TextStyle(
                        color: textColor!.withOpacity(0.6),
                        fontSize: 12.sp)),
              ],
            ),
          ),

          Icon(Icons.arrow_forward_ios,
              size: 16.sp,
              color: textColor.withOpacity(0.6))
        ],
      ),
    );
  }
}