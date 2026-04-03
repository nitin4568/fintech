import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../view_models/controller/home_controller/home_controller.dart';

class MonthlySpending extends StatelessWidget {
  final HomeVM vm = Get.find();

  MonthlySpending({super.key});

  final List<Color> colors = [
    Color(0xFF3B82F6),
    Color(0xFF60A5FA),
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;

    return Obx(() {
      if (vm.transactions.isEmpty) {
        return Text(
          "No spending yet",
          style: TextStyle(
            color: textColor!.withOpacity(0.6),
            fontSize: 14.sp,
          ),
        );
      }

      Map<String, double> data = {};

      for (var tx in vm.transactions) {
        if (!tx.isIncome) {
          data[tx.category] =
              (data[tx.category] ?? 0) + tx.amount.abs();
        }
      }

      if (data.isEmpty) {
        return Text(
          "No expenses yet",
          style: TextStyle(
            color: textColor!.withOpacity(0.6),
            fontSize: 14.sp,
          ),
        );
      }

      double total =
      data.values.fold(0.0, (a, b) => a + b);

      final entries = data.entries.toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "Monthly Spending",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),

          SizedBox(height: 16.h),

          Row(
            children: [

              SizedBox(
                height: 120.h,
                width: 120.w,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 2.w,
                    centerSpaceRadius: 40.r,
                    sections: List.generate(entries.length, (index) {
                      final e = entries[index];

                      return PieChartSectionData(
                        value: e.value,
                        color: colors[index % colors.length],
                        radius: 12.r,
                        showTitle: false,
                      );
                    }),
                  ),
                ),
              ),

              SizedBox(width: 20.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(entries.length, (index) {
                    final e = entries[index];

                    double percent = total == 0
                        ? 0
                        : (e.value / total * 100);

                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        children: [
                          Container(
                            width: 10.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              color: colors[index % colors.length],
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              "${e.key} ${percent.toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: textColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              )
            ],
          )
        ],
      );
    });
  }
}