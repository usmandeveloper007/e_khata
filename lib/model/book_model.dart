class BookModel {
  String? title;
  double netBalance;
  double totalCashIn;
  double totalCashOut;

  List<Transaction> transaction;
  BookModel({
    required this.title,
    this.netBalance = 0.0,
    this.totalCashIn = 0.0,
    this.totalCashOut = 0.0,
    this.transaction = const [],
  });

  void addTransaction(Transaction newTransaction) {
    transaction = [...transaction, newTransaction];
    if (newTransaction.type == 'Cash In') {
      totalCashIn += newTransaction.cashInAmount ?? 0.0;
      netBalance += newTransaction.cashInAmount ?? 0.0;
    } else {
      totalCashOut += newTransaction.cashOutAmount ?? 0.0;
      netBalance -= newTransaction.cashOutAmount ?? 0.0;
    }
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
