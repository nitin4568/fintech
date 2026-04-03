import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_models/controller/TransactionController.dart';
import '../../view_models/controller/home_controller/home_controller.dart';
import '../../models/home_models/TransactionModel.dart';

class AddTransactionScreen extends StatelessWidget {
  final HomeVM vm = Get.find();
  final AddTransactionVM addVM = Get.put(AddTransactionVM());

  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  AddTransactionScreen({super.key});

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
          "Add Transaction",
          style: TextStyle(color: textColor, fontSize: 18.sp),
        ),
        iconTheme: IconThemeData(color: textColor),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [

              Column(
                children: [
                  Text("ENTER AMOUNT",
                      style: TextStyle(
                          color: textColor.withOpacity(0.6),
                          fontSize: 12.sp)),
                  SizedBox(height: 10.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("₹",
                          style: TextStyle(
                              fontSize: 28.sp, color: textColor)),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 32.sp, color: textColor),
                          decoration: InputDecoration(
                            hintText: "0",
                            hintStyle: TextStyle(
                                color: textColor.withOpacity(0.4)),
                            border: InputBorder.none,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20.h),

          Obx(() => Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Row(
              children: [

                /// 🔻 EXPENSE
                Expanded(
                  child: GestureDetector(
                    onTap: () => addVM.isIncome.value = false,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: !addVM.isIncome.value
                            ? const Color(0xFF3B82F6).withOpacity(0.15)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Center(
                        child: Text(
                          "Expense",
                          style: TextStyle(
                            color: !addVM.isIncome.value
                                ? const Color(0xFF3B82F6)
                                : Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                /// 🔺 INCOME
                Expanded(
                  child: GestureDetector(
                    onTap: () => addVM.isIncome.value = true,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: addVM.isIncome.value
                            ? const Color(0xFF3B82F6).withOpacity(0.15)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Center(
                        child: Text(
                          "Income",
                          style: TextStyle(
                            color: addVM.isIncome.value
                                ? const Color(0xFF3B82F6)
                                : Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),

              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Text("Category",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: textColor)),
                  Text("See all",
                      style: TextStyle(
                          color: Color(0xFF3B82F6),
                          fontSize: 13.sp)),
                ],
              ),

              SizedBox(height: 10.h),

              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: [
                  _category(context, "Food", Icons.restaurant),
                  _category(context, "Travel", Icons.directions_car),
                  _category(context, "Shop", Icons.shopping_bag),
                  _category(context, "Fun", Icons.celebration),
                  _category(context, "Bills", Icons.receipt),
                  _category(context, "Health", Icons.medical_services),
                ],
              ),

              SizedBox(height: 20.h),

              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: TextField(
                  controller: noteController,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    hintText: "Add a description...",
                    hintStyle: TextStyle(
                        color: textColor.withOpacity(0.5)),
                    border: InputBorder.none,
                  ),
                ),
              ),

              SizedBox(height: 10.h),

              GestureDetector(
                onTap: () => addVM.pickImage(),
                child: Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: textColor.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(14.r),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Obx(() => addVM.imagePath.value.isEmpty
                      ? Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt,
                          color: textColor),
                      Text("Attach Receipt",
                          style: TextStyle(
                              color: textColor)),
                    ],
                  )
                      : ClipRRect(
                    borderRadius:
                    BorderRadius.circular(14.r),
                    child: Image.file(
                      File(addVM.imagePath.value),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )),
                ),
              ),

              SizedBox(height: 50.h),

              SizedBox(
                width: double.infinity,
                child:ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6), // 🔵 Blue
                    foregroundColor: Colors.white, // 🔥 IMPORTANT (text white)
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  onPressed: () {
                    double amount =
                        double.tryParse(amountController.text) ?? 0;

                    vm.addTransaction(
                      TransactionModel(
                        title: noteController.text.isEmpty
                            ? "General"
                            : noteController.text,
                        category: addVM.selectedCategory.value,
                        amount: amount,
                        isIncome: addVM.isIncome.value,
                        note: noteController.text,
                        imagePath: addVM.imagePath.value,
                      ),
                    );

                    Get.back();
                  },
                  child: Text(
                    "SAVE TRANSACTION",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white, // 🔥 Force white
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _category(
      BuildContext context, String name, IconData icon) {
    final addVM = Get.find<AddTransactionVM>();
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Obx(() => GestureDetector(
      onTap: () => addVM.selectCategory(name),
      child: Container(
        width: 80.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: addVM.selectedCategory.value == name
              ? const Color(0xFF3B82F6).withOpacity(0.2)
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: addVM.selectedCategory.value == name
                ? const Color(0xFF3B82F6)
                : Colors.transparent,
          ),
        ),
        child: Column(
          children: [
            Icon(icon,
                color: addVM.selectedCategory.value == name
                    ? const Color(0xFF3B82F6)
                    : textColor),
            SizedBox(height: 5.h),
            Text(name,
                style: TextStyle(
                    fontSize: 12.sp,
                    color: textColor)),
          ],
        ),
      ),
    ));
  }
}