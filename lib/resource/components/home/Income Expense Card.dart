import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final double amount;
  final bool isIncome;

  const InfoCard({
    super.key,
    required this.title,
    required this.amount,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        children: [

          CircleAvatar(
            radius: 16.r,
            backgroundColor: isIncome
                ? Colors.green.withOpacity(0.15)
                : Colors.red.withOpacity(0.15),
            child: Icon(
              isIncome ? Icons.arrow_upward : Icons.arrow_downward,
              size: 18.sp,
              color: isIncome ? Colors.green : Colors.red,
            ),
          ),

          SizedBox(width: 10.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor.withOpacity(0.6),
                    fontSize: 12.sp,
                  ),
                ),

                SizedBox(height: 4.h),

                Text(
                  amount == 0
                      ? "₹0"
                      : "₹${amount.toStringAsFixed(0)}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: textColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}