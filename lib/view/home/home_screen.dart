import 'dart:developer';
import 'package:cash_book/path_file.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: context.screenHeight * 0.125,
                    width: context.screenWidth,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.homeBannerGradient1,
                          AppColors.homeBannerGradient2
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                AppStrings.dashBoard,
                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.whiteColor,
                                child: Image.asset(
                                  AppImages.appLogo,
                                  scale: 5,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: context.screenHeight * 0.025,
                          ),
                          RichText(
                            text: const TextSpan(
                              text: AppStrings.hi,
                              style: TextStyle(
                                color: AppColors.lightWhiteColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                TextSpan(text: 'Usman'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.01,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      AppStrings.books,
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  homeProvider.bookList.isEmpty
                      ? const Center(
                          child: Text(
                            "There is no books Please add the book first.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.redColor,
                              fontSize: 12,
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: homeProvider.bookList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: Card(
                                elevation: 2,
                                child: ListTile(
                                  onTap: () {
                                    homeProvider.selectBook(index,
                                        homeProvider.bookList[index].title!);
                                    Navigator.of(context).pushNamed(
                                      RouteNames.transactionScreen,
                                    );
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  tileColor: AppColors.primaryColor,
                                  leading: const Icon(
                                    Icons.book_sharp,
                                    color: AppColors.whiteColor,
                                    size: 22,
                                  ),
                                  title: Text(
                                    homeProvider.bookList[index].title!,
                                    style: const TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                ],
              ),
            ),
            bottomNavigationBar: CustomButton(
              onPress: () {
                AddBook.showAddBookBottomSheet(context, homeProvider);
              },
              text: AppStrings.addBooks,
            ),
          ),
        );
      },
    );
  }
}
