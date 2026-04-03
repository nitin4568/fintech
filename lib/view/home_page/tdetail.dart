import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/home_models/TransactionModel.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel tx;

  const TransactionDetailScreen({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        title: Text(
          "Transaction Detail",
          style: TextStyle(color: textColor, fontSize: 18.sp),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        foregroundColor: textColor,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: tx.isIncome
                    ? Colors.green.withOpacity(0.15)
                    : Colors.red.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                "${tx.isIncome ? "+" : "-"}₹${tx.amount.abs().toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: tx.isIncome ? Colors.green : Colors.red,
                ),
              ),
            ),

            SizedBox(height: 20.h),

            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  _row(context, Icons.title, "Title", tx.title),
                  _row(context, Icons.category, "Category", tx.category),
                  _row(context, Icons.notes, "Description",
                      tx.note ?? "No description"),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            Text(
              "Receipt",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: textColor,
              ),
            ),

            SizedBox(height: 10.h),

            if (tx.imagePath != null && tx.imagePath!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.file(
                  File(tx.imagePath!),
                  height: 220.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                height: 120.h,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  "No image attached",
                  style: TextStyle(
                    color: textColor.withOpacity(0.6),
                    fontSize: 13.sp,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _row(BuildContext context, IconData icon, String title, String value) {
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: textColor.withOpacity(0.6)),
          SizedBox(width: 10.w),
          Text(
            "$title:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: textColor,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(width: 5.w),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: textColor,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}