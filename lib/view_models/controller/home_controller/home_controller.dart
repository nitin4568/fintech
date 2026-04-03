import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../models/home_models/TransactionModel.dart';

class HomeVM extends GetxController {
  final box = GetStorage();

  /// 🔥 DATA
  var transactions = <TransactionModel>[].obs;

  var balance = 0.0.obs;
  var income = 0.0.obs;
  var expense = 0.0.obs;

  /// 🔥 manual net worth
  var manualBalance = 0.0.obs;

  /// 🔥 NEW (goal target)
  var goalTarget = 5000.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  /// 🔥 LOAD DATA
  void loadData() {
    final data = box.read("transactions");
    final manual = box.read("manualBalance");
    final target = box.read("goalTarget");

    /// transactions
    if (data != null) {
      transactions.value = (data as List)
          .map((e) => TransactionModel.fromJson(e))
          .toList();
    } else {
      transactions.clear();
    }

    /// manual balance
    manualBalance.value = manual ?? 0;

    /// goal target
    goalTarget.value = target ?? 5000;

    calculateTotals();
  }

  /// 🔥 SAVE TRANSACTIONS
  void saveData() {
    box.write(
      "transactions",
      transactions.map((e) => e.toJson()).toList(),
    );
  }

  /// 🔥 SAVE MANUAL BALANCE
  void saveManualBalance(double value) {
    manualBalance.value = value;
    box.write("manualBalance", value);
    calculateTotals();
  }

  /// 🔥 SAVE GOAL TARGET
  void saveTarget(double value) {
    goalTarget.value = value;
    box.write("goalTarget", value);
  }

  /// 🔥 ADD TRANSACTION
  void addTransaction(TransactionModel tx) {
    transactions.add(tx);
    saveData();
    calculateTotals();
  }

  /// 🔥 DELETE TRANSACTION
  void deleteTransaction(int index) {
    transactions.removeAt(index);
    saveData();
    calculateTotals();
  }

  /// 🔥 TOTAL CALCULATION
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

    /// 🔥 FINAL BALANCE
    balance.value = manualBalance.value + (inc - exp);
  }

  /// 🔥 GOAL PROGRESS
  double getProgress() {
    if (goalTarget.value == 0) return 0;

    return (balance.value / goalTarget.value).clamp(0, 1);
  }
}