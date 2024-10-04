class BookModel {
  String? title;
  List<Transaction> transaction;
  BookModel({
    required this.title,
    this.transaction = const [],
  });

  void addTransaction(Transaction newTransaction) {
    transaction = [...transaction, newTransaction];
  }
}

class Transaction {
  String? bookTitle;
  double? netBalance;
  double? cashInAmount;
  double? cashOutAmount;
  double? balanceAfterTransaction;
  String? time;
  String? type;
  String? dateTime;
  String? purpose;
  String? modeOfPayment;

  Transaction({
    required this.bookTitle,
    required this.netBalance,
    required this.cashInAmount,
    required this.cashOutAmount,
    required this.type,
    required this.dateTime,
    required this.purpose,
    required this.modeOfPayment,
    required this.balanceAfterTransaction,
    required this.time,
  });
}
