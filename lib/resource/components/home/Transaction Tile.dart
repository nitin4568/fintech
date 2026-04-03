import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/home_models/TransactionModel.dart';
import '../../../view/home_page/tdetail.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel tx;

  const TransactionTile({
    super.key,
    required this.tx,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: () {
        Get.to(() => TransactionDetailScreen(tx: tx));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [

            CircleAvatar(
              radius: 20.r,
              backgroundColor: tx.isIncome
                  ? Colors.green.withOpacity(0.15)
                  : Colors.red.withOpacity(0.15),
              child: Icon(
                tx.isIncome
                    ? Icons.arrow_upward
                    : Icons.arrow_downward,
                size: 18.sp,
                color: tx.isIncome ? Colors.green : Colors.red,
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    tx.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: textColor.withOpacity(0.6),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "${tx.isIncome ? "+" : "-"}₹${tx.amount.abs().toStringAsFixed(0)}",
              style: TextStyle(
                color: tx.isIncome ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}