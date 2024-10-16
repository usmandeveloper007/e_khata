import 'dart:developer';

import 'package:cash_book/path_file.dart';
import 'package:intl/intl.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    transactionLog();
    updateNullBalances();
  }
  void transactionLog() {
    // Log all transactions in Map format
    final transactions = _bookList[_selectedBookIndex!].transaction.map((t) {
      return {
        'bookTitle': t.bookTitle,
        'netBalance': t.netBalance,
        'cashInAmount': t.cashInAmount,
        'cashOutAmount': t.cashOutAmount,
        'balanceAfterTransaction': t.balanceAfterTransaction,
        'time': t.time,
        'type': t.type,
        'dateTime': t.dateTime,
        'purpose': t.purpose,
        'modeOfPayment': t.modeOfPayment,
      };
    }).toList();
    log("All Transactions for the book title : $_selectedBookTitle are --> $transactions");
  }

  TextEditingController bookTitle = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController purpose = TextEditingController();

  final List<BookModel> _bookList = [];
  List<BookModel> get bookList => _bookList;
  int? _selectedBookIndex;
  int get selectedBookIndex => _selectedBookIndex!;
  String? _selectedBookTitle;
  String? get selectedBookTitle => _selectedBookTitle;
  bool? _isCashIn;
  bool? get isCashIn => _isCashIn;
  double? _netBalance;
  double? get netBalance => _netBalance;
  double? _cashInAmount;
  double? get cashInAmount => _cashInAmount;
  double? _cashOutAmount;
  double? get cashOutAmount => _cashOutAmount;
  String? _transactionType;
  String? get transactionType => _transactionType;
  double? _totalCashIn;
  double? get totalCashIn => _totalCashIn;
  double? _totalCashOut;
  double? get totalCashOut => _totalCashOut;

  void addBookToList(String bookTitle) {
    _bookList.add(
      BookModel(
        title: bookTitle,
      ),
    );
    notifyListeners();
  }

  void selectBook(int bookIndex, String bookTitle) {
    _selectedBookIndex = bookIndex;
    _selectedBookTitle = bookTitle;
    log('The selected book index is $_selectedBookIndex and title is $_selectedBookTitle');
    notifyListeners();
  }

  void updateNullBalances() {
    if (_netBalance == null && _totalCashIn == null && _totalCashOut == null) {
      _netBalance = 0.0;
      _totalCashIn = 0.0;
      _totalCashOut = 0.0;
      notifyListeners();
    }
  }

  void addTransactionToSelectedBook(bool paymentType) {
    if (_selectedBookIndex != null) {
      log('adding transaction!');
      Transaction newTransaction = Transaction(
        bookTitle: bookTitle.text,
        netBalance: _netBalance,
        cashInAmount: _cashInAmount,
        cashOutAmount: _cashOutAmount,
        type: _transactionType,
        dateTime: formattedDate,
        purpose: purpose.text,
        modeOfPayment: _selectedPaymentMode,
        balanceAfterTransaction: _netBalance,
        time: formattedTime,
      );
      _bookList[_selectedBookIndex!].addTransaction(newTransaction);
      notifyListeners();
    } else {
      log('no book selected!');
    }
  }

  void paymentType(bool value) {
    _isCashIn = value;
    value
        ? _cashInAmount = double.tryParse(amount.text)
        : _cashOutAmount = double.tryParse(amount.text);
    notifyListeners();
  }

  void updateTransactionType(bool value) {
    value ? _transactionType = 'Cash In' : _transactionType = 'Cash Out';
    log("transaction type : $_transactionType");
    notifyListeners();
  }

  List<Transaction> getSelectedBookTransactions() {
    if (_selectedBookIndex != null) {
      return _bookList[_selectedBookIndex!].transaction;
    } else {
      return [];
    }
  }

  // date & time functionality
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  DateTime? get selectedDate => _selectedDate;
  TimeOfDay? get selectedTime => _selectedTime;
  String get formattedDate {
    if (_selectedDate == null) {
      return DateFormat('MMMM d\'th\', yyyy').format(DateTime.now());
    }
    return DateFormat('MMMM d\'th\', yyyy').format(_selectedDate!);
  }

  String get formattedTime {
    if (_selectedTime == null) {
      return DateFormat.jm().format(DateTime.now());
    }
    final currentDT = DateTime.now();
    final time = DateTime(currentDT.year, currentDT.month, currentDT.day,
        _selectedTime!.hour, _selectedTime!.minute);

    return DateFormat.jm().format(time);
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );

    log('Picked Date :: ${pickedDate.toString()}');
    _selectedDate = pickedDate;
    notifyListeners();
  }

  Future<void> pickTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    log('Picked Time :: $pickedTime');
    _selectedTime = pickedTime;
    notifyListeners();
  }

  // payment mode
  String? _selectedPaymentMode;
  String? get selectedPaymentMode => _selectedPaymentMode;

  void updatePaymentMode(String value) {
    _selectedPaymentMode = value;
    notifyListeners();
  }
}
