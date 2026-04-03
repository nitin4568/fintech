import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoalProgress extends StatelessWidget {
  final double progress;
  final int target;

  const GoalProgress({
    super.key,
    required this.progress,
    this.target = 50000,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    double safeProgress = progress.clamp(0, 1);
    int current = (safeProgress * target).toInt();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Goal",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: textColor,
                ),
              ),
              Text(
                "${(safeProgress * 100).toInt()}%",
                style: TextStyle(
                  color: const Color(0xFF3B82F6),
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),

          SizedBox(height: 4.h),

          Text(
            "₹$current of ₹$target target",
            style: TextStyle(
              color: textColor.withOpacity(0.6),
              fontSize: 12.sp,
            ),
          ),

          SizedBox(height: 12.h),

          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: safeProgress,
              minHeight: 8.h,
              backgroundColor: textColor.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation(
                Color(0xFF3B82F6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}