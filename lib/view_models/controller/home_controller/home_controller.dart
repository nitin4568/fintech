import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../models/home_models/TransactionModel.dart';

class HomeVM extends GetxController {
  final box = GetStorage();

  var transactions = <TransactionModel>[].obs;

  var balance = 0.0.obs;
  var income = 0.0.obs;
  var expense = 0.0.obs;

  var manualBalance = 0.0.obs;
  var goalTarget = 5000.0.obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() async {
    isLoading.value = true;

    final data = box.read("transactions");
    final manual = box.read("manualBalance");
    final target = box.read("goalTarget");

    if (data != null) {
      transactions.value = (data as List)
          .map((e) => TransactionModel.fromJson(e))
          .toList();
    } else {
      transactions.clear();
    }

    manualBalance.value = manual ?? 0;
    goalTarget.value = target ?? 5000;

    calculateTotals();

    isLoading.value = false;
  }

  void saveData() {
    box.write(
      "transactions",
      transactions.map((e) => e.toJson()).toList(),
    );
  }

  void saveManualBalance(double value) {
    manualBalance.value = value;
    box.write("manualBalance", value);
    calculateTotals();
  }

  void saveTarget(double value) {
    goalTarget.value = value;
    box.write("goalTarget", value);
  }

  void addTransaction(TransactionModel tx) {
    transactions.add(tx);
    saveData();
    calculateTotals();

    Get.snackbar(
      "Success",
      "Transaction added",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void deleteTransaction(TransactionModel tx) {
    transactions.remove(tx);
    saveData();
    calculateTotals();

    Get.snackbar(
      "Deleted",
      "Transaction removed",
      snackPosition: SnackPosition.BOTTOM,
      mainButton: TextButton(
        onPressed: () {
          addTransaction(tx);
        },
        child: const Text("UNDO"),
      ),
    );
  }

  void updateTransaction(TransactionModel oldTx, TransactionModel newTx) {
    int index = transactions.indexOf(oldTx);
    if (index != -1) {
      transactions[index] = newTx;
      saveData();
      calculateTotals();

      Get.snackbar(
        "Updated",
        "Transaction updated",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void calculateTotals() {
    double inc = 0;
    double exp = 0;

    for (var tx in transactions) {
      if (tx.isIncome) {
        inc += tx.amount;
      } else {
        exp += tx.amount.abs();
      }
    }

    income.value = inc;
    expense.value = exp;

    balance.value = manualBalance.value + (inc - exp);
  }

  double getProgress() {
    if (goalTarget.value == 0) return 0;
    return (balance.value / goalTarget.value).clamp(0, 1);
  }
}