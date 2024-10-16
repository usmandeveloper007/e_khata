import 'dart:developer';

import 'package:cash_book/path_file.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          homeProvider.transactionLog();
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.screenWidth,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            AppStrings.bookTitle,
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            homeProvider.selectedBookTitle.toString(),
                            style: const TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: context.screenHeight * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            AppStrings.netBalance,
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 18,
                            ),
                          ),
                          Consumer<HomeProvider>(
                            builder: (context, homeProvider, child) {
                              return Text(
                                homeProvider
                                    .bookList[homeProvider.selectedBookIndex]
                                    .netBalance
                                    .toString(),
                                style: const TextStyle(
                                    color: AppColors.blackColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            AppStrings.cashIn,
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 14,
                            ),
                          ),
                          Consumer<HomeProvider>(
                            builder: (context, homeProvider, child) {
                              return Text(
                                homeProvider
                                    .bookList[homeProvider.selectedBookIndex]
                                    .totalCashIn
                                    .toString(),
                                style: const TextStyle(
                                    color: AppColors.greenColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            AppStrings.cashOut,
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 14,
                            ),
                          ),
                          Consumer<HomeProvider>(
                            builder: (context, homeProvider, child) {
                              return Text(
                                homeProvider
                                    .bookList[homeProvider.selectedBookIndex]
                                    .totalCashOut
                                    .toString(),
                                style: const TextStyle(
                                    color: AppColors.redColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Transactions",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                homeProvider.bookList[homeProvider.selectedBookIndex]
                        .transaction.isEmpty
                    ? const SizedBox.shrink()
                    : Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const ScrollPhysics(),
                            itemCount: homeProvider
                                .bookList[homeProvider.selectedBookIndex]
                                .transaction
                                .length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  log(index.toString());
                                  Navigator.of(context).pushNamed(
                                    RouteNames.transactionDetailScreen,
                                    arguments: index,
                                  );
                                },
                                child: Container(
                                  width: context.screenWidth,
                                  decoration: BoxDecoration(
                                    color: AppColors.transactionBgColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: context.screenWidth * 0.15,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        decoration: BoxDecoration(
                                          color: homeProvider
                                                      .bookList[homeProvider
                                                          .selectedBookIndex]
                                                      .transaction[index]
                                                      .type ==
                                                  'Cash In'
                                              ? AppColors.greenLightColor
                                              : AppColors.redLightColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            homeProvider
                                                .bookList[homeProvider
                                                    .selectedBookIndex]
                                                .transaction[index]
                                                .type!
                                                .toString(),
                                            style: TextStyle(
                                              color: homeProvider
                                                          .bookList[homeProvider
                                                              .selectedBookIndex]
                                                          .transaction[index]
                                                          .type ==
                                                      'Cash In'
                                                  ? AppColors.greenColor
                                                  : AppColors.redColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              homeProvider
                                                          .bookList[homeProvider
                                                              .selectedBookIndex]
                                                          .transaction[index]
                                                          .type ==
                                                      'Cash In'
                                                  ? homeProvider
                                                      .bookList[homeProvider
                                                          .selectedBookIndex]
                                                      .transaction[index]
                                                      .cashInAmount
                                                      .toString()
                                                  : homeProvider
                                                      .bookList[homeProvider
                                                          .selectedBookIndex]
                                                      .transaction[index]
                                                      .cashOutAmount
                                                      .toString(),
                                              style: TextStyle(
                                                color: homeProvider
                                                            .bookList[homeProvider
                                                                .selectedBookIndex]
                                                            .transaction[index]
                                                            .type ==
                                                        'Cash In'
                                                    ? AppColors.greenColor
                                                    : AppColors.redColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                text: 'Balance: ',
                                                style: const TextStyle(
                                                    color: AppColors.black87,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11),
                                                children: [
                                                  TextSpan(
                                                    text: homeProvider
                                                        .bookList[homeProvider
                                                            .selectedBookIndex]
                                                        .transaction[index]
                                                        .balanceAfterTransaction
                                                        .toString(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        indent: 10,
                                        endIndent: 10,
                                        thickness: 0.2,
                                        height: 0,
                                        color: AppColors.greyColor,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            bottom: 8,
                                            right: 10,
                                            top: 14),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                  text: 'Date: ',
                                                  style: const TextStyle(
                                                    color: AppColors.greyColor,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: homeProvider
                                                          .bookList[homeProvider
                                                              .selectedBookIndex]
                                                          .transaction[index]
                                                          .dateTime
                                                          .toString(),
                                                    ),
                                                  ]),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  text: 'Time: ',
                                                  style: const TextStyle(
                                                    color: AppColors.greyColor,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: homeProvider
                                                          .bookList[homeProvider
                                                              .selectedBookIndex]
                                                          .transaction[index]
                                                          .time
                                                          .toString(),
                                                    ),
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
              ],
            ),
            bottomNavigationBar: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  onPress: () {
                    homeProvider.paymentType(true);
                    homeProvider.updateTransactionType(true);
                    AddTransaction.showAddTransactionBottomSheet(
                        context, homeProvider);
                  },
                  text: AppStrings.cashIn,
                  width: context.screenWidth * 0.45,
                  backgroundColor: AppColors.greenColor,
                ),
                CustomButton(
                  onPress: () {
                    homeProvider.paymentType(false);
                    homeProvider.updateTransactionType(false);
                    AddTransaction.showAddTransactionBottomSheet(
                        context, homeProvider);
                  },
                  text: AppStrings.cashOut,
                  width: context.screenWidth * 0.45,
                  backgroundColor: AppColors.redColor,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
