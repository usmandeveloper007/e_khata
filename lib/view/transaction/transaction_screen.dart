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
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: context.screenWidth,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
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
                                  homeProvider.netBalance.toString(),
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
                                  homeProvider.totalCashIn.toString(),
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
                                  homeProvider.totalCashOut.toString(),
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
                  Text("Transactions"),
                  homeProvider.bookList[homeProvider.selectedBookIndex]
                          .transaction.isEmpty
                      ? const SizedBox.shrink()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: homeProvider
                              .bookList[homeProvider.selectedBookIndex]
                              .transaction
                              .length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: context.screenHeight * 0.1,
                              width: context.screenWidth,
                              decoration: BoxDecoration(
                                color: AppColors.lightWhiteColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: context.screenHeight * 0.03,
                                    width: context.screenWidth * 0.15,
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.blackColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      homeProvider
                                          .bookList[
                                              homeProvider.selectedBookIndex]
                                          .transaction[index]
                                          .type!
                                          .toString(),
                                      style: const TextStyle(
                                          color: AppColors.whiteColor),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                ],
              ),
            ),
            bottomNavigationBar: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  onPress: () {
                    homeProvider.paymentType(true);
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
