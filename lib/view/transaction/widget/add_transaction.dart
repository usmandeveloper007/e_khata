import 'package:cash_book/path_file.dart';

class AddTransaction {
  static showAddTransactionBottomSheet(
      context, HomeProvider homeProvider, bool isCashIn) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Wrap(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isCashIn
                        ? AppStrings.addCashInAmount
                        : AppStrings.addCashOutAmount,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextField(
                      controller: homeProvider.amount,
                      hintText: isCashIn
                          ? 'Please enter the cash in amount'
                          : 'Please enter the cash out amount',
                      labelText:
                          isCashIn ? 'Cash In Amount' : 'Cash Out Amount',
                      hintTextColor: AppColors.blackColor,
                    ),
                  ),
                  CustomButton(
                    onPress: () {
                      homeProvider.addBookToList(homeProvider.bookTitle.text);
                      homeProvider.bookTitle.clear();
                      Navigator.of(context).pop();
                    },
                    text: AppStrings.addTransaction,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
