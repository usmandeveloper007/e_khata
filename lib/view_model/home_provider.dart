import 'dart:developer';

import 'package:cash_book/path_file.dart';
import 'package:intl/intl.dart';

class HomeProvider extends ChangeNotifier {
  void transactionLog() {
    log(' book index:: $_selectedBookIndex');
    log(' book title:: $_selectedBookTitle');
    log(' transaction_amount:: ${amount.text.toString()}');
    log(' transation_date:: $_selectedDate');
    log(' transation_time:: $_selectedTime');
    log(' transation_mode:: $_selectedPaymentMode');
  }

  TextEditingController bookTitle = TextEditingController();
  TextEditingController amount = TextEditingController();

  List<BookModel> _bookList = [];
  List<BookModel> get bookList => _bookList;
  int? _selectedBookIndex;
  int get selectedBookIndex => _selectedBookIndex!;
  String? _selectedBookTitle;
  String? get selectedBookTitle => _selectedBookTitle;

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

  void addTransactionToSelectedBook(Transaction transaction) {
    if (_selectedBookIndex != null) {
      _bookList[_selectedBookIndex!].addTransaction(transaction);
      notifyListeners();
    } else {
      log('no book selected!');
    }
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
