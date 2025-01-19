import 'dart:developer';

import 'package:cash_book/path_file.dart';

class AddTransaction {
  static showAddTransactionBottomSheet(context, HomeProvider homeProvider) {
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
                    homeProvider.isCashIn!
                        ? AppStrings.addCashInAmount
                        : AppStrings.addCashOutAmount,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          homeProvider.pickDate(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: AppColors.blackColor,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Consumer<HomeProvider>(
                              builder: (context, dateProvider, child) {
                                return Text(
                                  dateProvider.formattedDate,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          homeProvider.pickTime(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.timelapse_sharp,
                              color: AppColors.blackColor,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Consumer<HomeProvider>(
                              builder: (context, timeProvider, child) {
                                return Text(
                                  timeProvider.formattedTime,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextField(
                      controller: homeProvider.amount,
                      keyboardType: TextInputType.number,
                      hintText: homeProvider.isCashIn!
                          ? 'Please enter the cash in amount'
                          : 'Please enter the cash out amount',
                      labelText: homeProvider.isCashIn!
                          ? 'Cash In Amount'
                          : 'Cash Out Amount',
                      hintTextColor: AppColors.blackColor,
                    ),
                  ),
                  DropdownButtonFormField(
                    items: const [
                      DropdownMenuItem(
                        value: 'online',
                        child: Text('Online'),
                      ),
                      DropdownMenuItem(
                        value: 'cash',
                        child: Text('Cash'),
                      ),
                    ],
                    onChanged: (value) {
                      log(value!);
                      homeProvider.updatePaymentMode(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Select Payment Mode',
                      labelStyle: TextStyle(color: AppColors.primaryColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: AppColors.blackColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: AppColors.blackColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                        color: AppColors.blackColor,
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: homeProvider.purpose,
                    hintText: 'Please enter the reason...',
                    labelText: 'Reason',
                    hintTextColor: AppColors.blackColor,
                    maxLines: 2,
                  ),
                  CustomButton(
                    onPress: () {
                      homeProvider.paymentType(homeProvider.isCashIn!);
                      homeProvider
                          .addTransactionToSelectedBook(homeProvider.isCashIn!);

                      // homeProvider.transactionLog();
                      homeProvider.amount.clear();
                      homeProvider.purpose.clear();
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
