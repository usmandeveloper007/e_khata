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
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.netBalance,
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '0.00',
                              style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.cashIn,
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '0.00',
                              style: TextStyle(
                                  color: AppColors.greenColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.cashOut,
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '0.00',
                              style: TextStyle(
                                  color: AppColors.redColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  onPress: () {
                    AddTransaction.showAddTransactionBottomSheet(
                        context, homeProvider, true);
                  },
                  text: AppStrings.cashIn,
                  width: context.screenWidth * 0.45,
                  backgroundColor: AppColors.greenColor,
                ),
                CustomButton(
                  onPress: () {
                    AddTransaction.showAddTransactionBottomSheet(
                        context, homeProvider, false);
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
