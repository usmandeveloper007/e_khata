import 'dart:developer';

import 'package:cash_book/path_file.dart';
import 'package:intl/intl.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    updateNullBalances();
  }
  void transactionLog() {
    log(' book index:: $_selectedBookIndex');
    log(' book title:: $_selectedBookTitle');
    log(' transaction_amount:: ${amount.text.toString()}');
    log(' transation_date:: $_selectedDate');
    log(' transation_time:: $_selectedTime');
    log(' transation_mode:: $_selectedPaymentMode');
    log(' transation_type:: $transactionType');
    log('All Transactions :: ${_bookList[_selectedBookIndex!].transaction.toString()}');
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
      BookModel(title: bookTitle),
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
      // calculating net balance
      _netBalance ??= 0.0;
      _totalCashIn ??= 0.0;
      _totalCashOut ??= 0.0;
      double parsedAmount = double.tryParse(amount.text) ?? 0;
      if (isCashIn == true) {
        _totalCashIn = _totalCashIn! + parsedAmount;
        _netBalance = _netBalance! + parsedAmount;
      } else {
        _totalCashOut = _totalCashOut! + parsedAmount;
        _netBalance = _netBalance! - parsedAmount;
      }

      log('New Net Balance: $_netBalance');
      Transaction newTransaction = Transaction(
        bookTitle: bookTitle.text,
        netBalance: netBalance,
        cashInAmount: cashInAmount,
        cashOutAmount: cashOutAmount,
        type: transactionType,
        dateTime: formattedDate,
        purpose: purpose.text,
        modeOfPayment: _selectedPaymentMode,
        balanceAfterTransaction: netBalance,
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
    value ? _transactionType = 'Cash In' : 'Cash Out';
    notifyListeners();
    value
        ? _cashInAmount == double.tryParse(amount.text)
        : _cashOutAmount == double.tryParse(amount.text);
    notifyListeners();
  }

  List<Transaction> getSelectedBookTransactions() {
    if (_selectedBookIndex != null) {
      return _bookList[_selectedBookIndex!].transaction;
    } else {
      return [];
    }
  }

  // transaction details

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
