import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_models/controller/home_controller/home_controller.dart';
import 'Add Transaction Screen.dart';

class TransactionScreen extends StatelessWidget {
  final HomeVM vm = Get.find();

  TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Transactions",
          style: TextStyle(color: textColor, fontSize: 18.sp),
        ),
        iconTheme: IconThemeData(color: textColor),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [

            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: TextField(
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: "Search transactions...",
                  hintStyle:
                  TextStyle(color: textColor.withOpacity(0.5)),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: textColor),
                ),
              ),
            ),

            SizedBox(height: 12.h),

            Row(
              children: [
                _chip(context, "All", true),
                SizedBox(width: 8.w),
                _chip(context, "Income", false),
                SizedBox(width: 8.w),
                _chip(context, "Expenses", false),
              ],
            ),

            SizedBox(height: 16.h),

            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text("MONTHLY TREND",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xFF3B82F6))),
                      SizedBox(height: 5.h),
                      Text("Spends are down by 12%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: textColor,
                              fontSize: 13.sp)),
                    ],
                  ),
                  const Icon(Icons.show_chart,
                      color: Color(0xFF3B82F6))
                ],
              ),
            ),

            SizedBox(height: 16.h),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "RECENT TRANSACTIONS",
                style: TextStyle(
                    color: textColor.withOpacity(0.6),
                    fontSize: 12.sp),
              ),
            ),

            SizedBox(height: 10.h),

            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: vm.transactions.length,
                itemBuilder: (context, index) {
                  final tx = vm.transactions[index];
                  return _transactionTile(context, tx);
                },
              )),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        heroTag: "transactionFAB",
        backgroundColor: const Color(0xFF3B82F6),
        onPressed: () {
          Get.to(() => AddTransactionScreen());
        },
        child: Icon(Icons.add, size: 22.sp),
      ),
    );
  }

  Widget _chip(BuildContext context, String text, bool selected) {
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Container(
      padding:
      EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: selected
            ? const Color(0xFF3B82F6)
            : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : textColor,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  Widget _transactionTile(BuildContext context, tx) {
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [

          CircleAvatar(
            backgroundColor:
            const Color(0xFF3B82F6).withOpacity(0.15),
            child: const Icon(Icons.shopping_bag,
                color: Color(0xFF3B82F6)),
          ),

          SizedBox(width: 10.w),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(tx.title,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: textColor,
                        fontSize: 14.sp)),
                Text(tx.category,
                    style: TextStyle(
                        color: textColor.withOpacity(0.6),
                        fontSize: 12.sp)),
              ],
            ),
          ),

          Text(
            "${tx.isIncome ? "+" : "-"}₹${tx.amount.abs()}",
            style: TextStyle(
              color: tx.isIncome ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
            ),
          )
        ],
      ),
    );
  }
}