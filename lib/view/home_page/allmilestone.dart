import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_models/controller/home_controller/home_controller.dart';

class AllMilestonesScreen extends StatelessWidget {
  final HomeVM vm = Get.find();

  AllMilestonesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        title: Text(
          "All Milestones",
          style: TextStyle(color: textColor, fontSize: 18.sp),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        foregroundColor: textColor,
      ),

      body: Obx(() {
        Map<String, double> data = {};

        for (var tx in vm.transactions) {
          if (!tx.isIncome) {
            data[tx.category] =
                (data[tx.category] ?? 0) + tx.amount.abs();
          }
        }

        if (data.isEmpty) {
          return Center(
            child: Text(
              "No data",
              style: TextStyle(
                color: textColor.withOpacity(0.6),
                fontSize: 14.sp,
              ),
            ),
          );
        }

        return ListView(
          padding: EdgeInsets.all(16.w),
          children: data.entries.map((e) {
            double progress = (e.value / 10000).clamp(0, 1);

            return Container(
              margin: EdgeInsets.only(bottom: 10.h),
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    e.key,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),

                  SizedBox(height: 6.h),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6.h,
                      backgroundColor:
                      textColor.withOpacity(0.1),
                      valueColor:
                      const AlwaysStoppedAnimation(
                        Color(0xFF3B82F6),
                      ),
                    ),
                  ),

                  SizedBox(height: 6.h),

                  Text(
                    "₹${e.value.toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: textColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      }),
    );
  }
}