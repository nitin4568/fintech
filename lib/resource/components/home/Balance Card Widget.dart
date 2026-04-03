import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../view_models/controller/home_controller/home_controller.dart';

class BalanceCard extends StatelessWidget {
  final double balance;

  const BalanceCard({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;

    return GestureDetector(
      onTap: () => _showAddBalanceDialog(context),

      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10.r,
              spreadRadius: 2.r,
            )
          ],
        ),
        child: Stack(
          children: [

            Positioned(
              right: -10.w,
              top: -10.h,
              child: Icon(
                Icons.show_chart,
                size: 100.sp,
                color: textColor!.withOpacity(0.05),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Total Net Worth",
                  style: TextStyle(
                    color: textColor.withOpacity(0.6),
                    fontSize: 14.sp,
                  ),
                ),

                SizedBox(height: 5.h),

                Text(
                  "₹${balance.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddBalanceDialog(BuildContext context) {
    final vm = Get.find<HomeVM>();
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    TextEditingController controller = TextEditingController();

    Get.defaultDialog(
      title: "Add Net Worth",
      titleStyle: TextStyle(color: textColor, fontSize: 16.sp),
      backgroundColor: Theme.of(context).cardColor,

      content: Column(
        children: [
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              hintText: "Enter amount",
              hintStyle: TextStyle(
                color: textColor!.withOpacity(0.5),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide:
                BorderSide(color: textColor.withOpacity(0.3)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                BorderSide(color: textColor),
              ),
            ),
          ),
        ],
      ),

      textConfirm: "Save",
      textCancel: "Cancel",

      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFF3B82F6),

      onConfirm: () {
        double value = double.tryParse(controller.text) ?? 0;
        vm.saveManualBalance(value);
        vm.calculateTotals();
        Get.back();
      },
    );
  }
}