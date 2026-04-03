import 'package:bankapp/view/home_page/tdetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_models/controller/home_controller/home_controller.dart';
import 'Add Transaction Screen.dart';

class TransactionScreen extends StatelessWidget {
  final HomeVM vm = Get.find();
  final RxString selectedFilter = "All".obs;
  final RxString searchQuery = "".obs;

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
              child:TextField(
                onChanged: (value) {
                  searchQuery.value = value.toLowerCase();
                },
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: "Search transactions...",
                  hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: textColor),
                ),
              ),
            ),

            SizedBox(height: 12.h),

            Obx(() => Row(
              children: [
                _chip(context, "All"),
                SizedBox(width: 8.w),
                _chip(context, "Income"),
                SizedBox(width: 8.w),
                _chip(context, "Expenses"),
              ],
            )),

            SizedBox(height: 16.h),

            Expanded(
              child: Obx(() {

                List filtered = vm.transactions;

                if (selectedFilter.value == "Income") {
                  filtered = vm.transactions.where((e) => e.isIncome).toList();
                } else if (selectedFilter.value == "Expenses") {
                  filtered = vm.transactions.where((e) => !e.isIncome).toList();
                }

                if (searchQuery.value.isNotEmpty) {
                  filtered = filtered.where((tx) {
                    return tx.title.toLowerCase().contains(searchQuery.value) ||
                        tx.category.toLowerCase().contains(searchQuery.value) ||
                        tx.amount.toString().contains(searchQuery.value);
                  }).toList();
                }

                if (selectedFilter.value == "Expenses") {
                  filtered.sort((a, b) =>
                      b.amount.abs().compareTo(a.amount.abs()));
                }

                if (filtered.isEmpty) {
                  return Center(
                    child: Text(
                      "No Transactions Yet",
                      style: TextStyle(
                        color: textColor.withOpacity(0.6),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final tx = filtered[index];
                    return _transactionTile(context, tx);
                  },
                );
              }),
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

  Widget _chip(BuildContext context, String text) {
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return GestureDetector(
      onTap: () => selectedFilter.value = text,
      child: Container(
        padding:
        EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selectedFilter.value == text
              ? const Color(0xFF3B82F6)
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selectedFilter.value == text
                ? Colors.white
                : textColor,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  Widget _transactionTile(BuildContext context, tx) {
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () {
        Get.to(() => TransactionDetailScreen(tx: tx));
      },
      child: Container(
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
      ),
    );
  }
}