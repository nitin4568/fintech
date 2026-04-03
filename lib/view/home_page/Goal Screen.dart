import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_models/controller/home_controller/home_controller.dart';
import 'allmilestone.dart';

class GoalScreen extends StatelessWidget {
  final HomeVM vm = Get.find();

  GoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Obx(() {
      double saved = vm.balance.value;
      double target = vm.goalTarget.value == 0 ? 1 : vm.goalTarget.value;

      double progress = (saved / target).clamp(0.0, 1.0);

      final contributions = vm.transactions
          .where((tx) => tx.isIncome)
          .toList()
          .reversed
          .take(2)
          .toList();

      Map<String, double> categoryMap = {};

      for (var tx in vm.transactions) {
        if (!tx.isIncome) {
          categoryMap[tx.category] =
              (categoryMap[tx.category] ?? 0) + tx.amount.abs();
        }
      }

      String topGoal = categoryMap.isEmpty
          ? "No Goal"
          : categoryMap.entries
          .reduce((a, b) => a.value > b.value ? a : b)
          .key;

      double topProgress = categoryMap.isEmpty
          ? 0
          : (categoryMap[topGoal]! / 10000).clamp(0.0, 1.0);

      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Ethereal Vault",
            style: TextStyle(color: textColor, fontSize: 18.sp),
          ),
        ),

        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: ListView(
            children: [

              Text(
                "Your Savings.",
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),

              SizedBox(height: 5.h),

              Text(
                "Steady growth is the foundation of lasting wealth.",
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: 13.sp,
                ),
              ),

              SizedBox(height: 20.h),

              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.15),
                        borderRadius:
                        BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        "ACTIVE GOAL",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Text(
                      "Monthly Saving Goal",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "₹${saved.toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        Text(
                          "₹${target.toStringAsFixed(0)}",
                          style: TextStyle(
                            color: textColor.withOpacity(0.6),
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 8.h,
                        backgroundColor:
                        textColor.withOpacity(0.1),
                        valueColor:
                        const AlwaysStoppedAnimation(
                            Color(0xFF3B82F6)),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Text(
                      "You saved ${(progress * 100).toInt()}%",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              GestureDetector(
                onTap: () => _showTargetDialog(context),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.settings,
                          color: Color(0xFF3B82F6)),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text("Adjust Target",
                            style: TextStyle(
                                color: textColor)),
                      ),
                      Text("Configure",
                          style: TextStyle(
                              color: const Color(0xFF3B82F6),
                              fontSize: 13.sp))
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Text("Other Milestones",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: textColor)),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => AllMilestonesScreen());
                    },
                    child: Text("View All",
                        style: TextStyle(
                            color: const Color(0xFF3B82F6),
                            fontSize: 13.sp)),
                  ),
                ],
              ),

              SizedBox(height: 10.h),

              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star,
                            color: Colors.green),
                        SizedBox(width: 10.w),
                        Expanded(
                            child: Text(topGoal,
                                style:
                                TextStyle(color: textColor))),
                        Text("${(topProgress * 100).toInt()}%",
                            style:
                            TextStyle(color: textColor)),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    LinearProgressIndicator(
                      value: topProgress,
                      minHeight: 6.h,
                      backgroundColor:
                      textColor.withOpacity(0.1),
                      valueColor:
                      const AlwaysStoppedAnimation(
                          Colors.green),
                    )
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              Text("Recent Contributions",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: textColor)),

              SizedBox(height: 10.h),

              contributions.isEmpty
                  ? Text("No contributions yet",
                  style: TextStyle(
                      color: textColor.withOpacity(0.6)))
                  : Column(
                children: contributions.map((tx) {
                  return _contributionTile(
                    context,
                    tx.title,
                    "+₹${tx.amount.toStringAsFixed(0)}",
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _contributionTile(
      BuildContext context, String title, String amount) {
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.withOpacity(0.15),
            child: const Icon(Icons.savings,
                color: Color(0xFF3B82F6)),
          ),
          SizedBox(width: 10.w),
          Expanded(
              child: Text(title,
                  style: TextStyle(color: textColor))),
          Text(amount,
              style: TextStyle(
                  color: Colors.green, fontSize: 13.sp)),
        ],
      ),
    );
  }

  void _showTargetDialog(BuildContext context) {
    TextEditingController controller =
    TextEditingController();

    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    Get.defaultDialog(
      title: "Set Target",
      titleStyle: TextStyle(color: textColor),
      backgroundColor: Theme.of(context).cardColor,
      content: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          hintText: "Enter amount",
          hintStyle:
          TextStyle(color: textColor.withOpacity(0.5)),
        ),
      ),
      textConfirm: "Save",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFF3B82F6),
      onConfirm: () {
        double value =
            double.tryParse(controller.text) ?? 0;
        vm.saveTarget(value);
        Get.back();
      },
    );
  }
}