class TransactionModel {
  String title;
  String category;
  double amount;
  bool isIncome;
  String? note;
  String? imagePath;

  TransactionModel({
    required this.title,
    required this.category,
    required this.amount,
    required this.isIncome,
    this.note,
    this.imagePath,
  });

  Map<String, dynamic> toJson() => {
    "title": title,
    "category": category,
    "amount": amount,
    "isIncome": isIncome,
    "note": note,
    "imagePath": imagePath,
  };

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      title: json["title"],
      category: json["category"],
      amount: json["amount"],
      isIncome: json["isIncome"],
      note: json["note"],
      imagePath: json["imagePath"],
    );
  }
}