import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_models/controller/home_controller/home_controller.dart';
import '../../resource/components/home/Balance Card Widget.dart';
import '../../resource/components/home/Income Expense Card.dart';
import '../../resource/components/home/Transaction Tile.dart';
import '../../resource/components/home/monthly.dart';
import '../../resource/components/home/progress_bar.dart';
import 'Add Transaction Screen.dart';
import 'Transaction History Screen.dart';

class HomeScreen extends StatelessWidget {
  final HomeVM vm = Get.find();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        title: Text(
          "Ethereal Vault",
          style: TextStyle(fontSize: 18.sp, color: textColor),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        foregroundColor: textColor,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                radius: 18.r,
                backgroundColor: const Color(0xFF3B82F6),
                child: const Icon(Icons.person, color: Colors.white),
              ),
            ),
          )
        ],
      ),

      body: Obx(() => ListView(
        padding: EdgeInsets.all(16.w),
        children: [

          BalanceCard(balance: vm.balance.value),

          SizedBox(height: 20.h),

          Row(
            children: [
              Expanded(
                child: InfoCard(
                  title: "Income",
                  amount: vm.income.value,
                  isIncome: true,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: InfoCard(
                  title: "Expense",
                  amount: vm.expense.value,
                  isIncome: false,
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          GoalProgress(progress: vm.getProgress()),

          SizedBox(height: 20.h),

          MonthlySpending(),

          SizedBox(height: 20.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => TransactionScreen());
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    color: const Color(0xFF3B82F6),
                    fontSize: 14.sp,
                  ),
                ),
              )
            ],
          ),

          SizedBox(height: 10.h),

          vm.transactions.isEmpty
              ? Center(
            child: Text(
              "No transactions yet",
              style: TextStyle(
                color: textColor!.withOpacity(0.6),
                fontSize: 14.sp,
              ),
            ),
          )
              : Column(
            children: vm.transactions
                .map((tx) => TransactionTile(tx: tx))
                .toList(),
          ),
        ],
      )),

      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF3B82F6),
          onPressed: () {
            Get.to(() => AddTransactionScreen());
          },
          child: Icon(Icons.add, size: 22.sp),
        ),
      ),
    );
  }
}