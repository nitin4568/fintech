import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_models/controller/home_controller/home_controller.dart';

class InsightsScreen extends StatelessWidget {
  final HomeVM vm = Get.find();

  InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Obx(() {
      final txs = vm.transactions;

      if (txs.isEmpty) {
        return Scaffold(
          backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text("Insights",
                style: TextStyle(color: textColor)),
            backgroundColor:
            Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            foregroundColor: textColor,
          ),
          body: Center(
            child: Text(
              "No data yet",
              style: TextStyle(
                  color: textColor.withOpacity(0.6)),
            ),
          ),
        );
      }

      double totalExpense = 0;
      Map<String, double> categoryMap = {};

      for (var tx in txs) {
        if (!tx.isIncome) {
          totalExpense += tx.amount.abs();

          categoryMap[tx.category] =
              (categoryMap[tx.category] ?? 0) +
                  tx.amount.abs();
        }
      }

      String topCategory = "";
      double max = 0;

      categoryMap.forEach((key, value) {
        if (value > max) {
          max = value;
          topCategory = key;
        }
      });

      List<FlSpot> spots = [];
      for (int i = 0; i < txs.length; i++) {
        spots.add(
            FlSpot(i.toDouble(), txs[i].amount.abs() / 1000));
      }

      return Scaffold(
        backgroundColor:
        Theme.of(context).scaffoldBackgroundColor,

        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text("Insights",
              style:
              TextStyle(color: textColor, fontSize: 18.sp)),
        ),

        body: ListView(
          padding: EdgeInsets.all(16.w),
          children: [

            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Monthly Trend",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: textColor)),
                      Text(
                          "₹${totalExpense.toStringAsFixed(0)}",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp)),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  SizedBox(
                    height: 150.h,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        titlesData:
                        FlTitlesData(show: false),
                        borderData:
                        FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            isCurved: true,
                            color:
                            const Color(0xFF3B82F6),
                            barWidth: 3.w,
                            spots: spots,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text("TOP EXPENSE",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.sp)),
                  SizedBox(height: 5.h),
                  Text(topCategory,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold)),
                  Text("₹${max.toStringAsFixed(0)}",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13.sp)),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text("Spending Categories",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: textColor)),

                  SizedBox(height: 10.h),

                  ...categoryMap.entries.map((e) {
                    double percent =
                    (e.value / totalExpense);

                    return _progress(
                        context,
                        e.key,
                        percent,
                        "₹${e.value.toStringAsFixed(0)}");
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _progress(BuildContext context, String title,
      double value, String amount) {
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(color: textColor)),
            Text(amount,
                style: TextStyle(color: textColor)),
          ],
        ),
        SizedBox(height: 5.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 6.h,
            backgroundColor:
            textColor.withOpacity(0.1),
            valueColor:
            const AlwaysStoppedAnimation(
                Color(0xFF3B82F6)),
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}