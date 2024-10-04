import 'package:cash_book/path_file.dart';

extension MediaQuerryExtention on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
}
