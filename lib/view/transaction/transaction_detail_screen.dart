import 'dart:developer';

import 'package:cash_book/path_file.dart';

class TransactionDetailScreen extends StatefulWidget {
  final int? transactionIndex;
  const TransactionDetailScreen({super.key, this.transactionIndex});

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // Safely handle null arguments

    if (widget.transactionIndex == null) {
      // If transactionIndex is null, handle the error
      log('Transaction index is null!');
      return const Scaffold(
        body: Center(
          child: Text('No transaction selected.'),
        ),
      );
    }

    log(widget.transactionIndex.toString());
    // final String bookTitle =
    //     ModalRoute.of(context)!.settings.arguments as String;
    // final String transactionType =
    //     ModalRoute.of(context)!.settings.arguments as String;
    // final String transactionAmount =
    //     ModalRoute.of(context)!.settings.arguments as String;
    // final String dateOfTransaction =
    //     ModalRoute.of(context)!.settings.arguments as String;
    // final String timeOfTransaction =
    //     ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  alignment: Alignment.center,
                  height: context.screenHeight * 0.4,
                  width: context.screenWidth,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Book Title: "),
                          Text(homeProvider
                              .bookList[homeProvider.selectedBookIndex].title
                              .toString()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Transaction Type: "),
                          Text(homeProvider
                              .bookList[homeProvider.selectedBookIndex]
                              .transaction[widget.transactionIndex!]
                              .type
                              .toString()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Transaction Date: "),
                          Text(homeProvider
                              .bookList[homeProvider.selectedBookIndex]
                              .transaction[widget.transactionIndex!]
                              .dateTime
                              .toString()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Transaction Time: "),
                          Text(homeProvider
                              .bookList[homeProvider.selectedBookIndex]
                              .transaction[widget.transactionIndex!]
                              .time
                              .toString()),
                        ],
                      ),
                    ],
                  )),
            ],
          );
        },
      ),
    );
  }
}
