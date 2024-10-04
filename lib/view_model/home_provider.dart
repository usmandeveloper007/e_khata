import 'dart:developer';

import 'package:cash_book/model/book_model.dart';
import 'package:cash_book/path_file.dart';

class HomeProvider extends ChangeNotifier {
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
}
