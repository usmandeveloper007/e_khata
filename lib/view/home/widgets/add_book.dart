import 'package:cash_book/path_file.dart';

class AddBook {
  static showAddBookBottomSheet(context, HomeProvider homeProvider) {
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
                  const Text(AppStrings.addBookTitle),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextField(
                      controller: homeProvider.bookTitle,
                      hintText: 'Please enter the book title',
                      labelText: 'Book title',
                      hintTextColor: AppColors.blackColor,
                    ),
                  ),
                  CustomButton(
                    onPress: () {
                      homeProvider.addBookToList(homeProvider.bookTitle.text);
                      homeProvider.bookTitle.clear();
                      Navigator.of(context).pop();
                    },
                    text: AppStrings.addBook,
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
