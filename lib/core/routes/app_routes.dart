import 'package:cash_book/path_file.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteNames.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteNames.transactionScreen:
        return MaterialPageRoute(builder: (_) => const TransactionScreen());
      case RouteNames.transactionDetailScreen:
        final transactionIndex = settings.arguments as int?;
        return MaterialPageRoute(
            builder: (_) =>
                TransactionDetailScreen(transactionIndex: transactionIndex));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text("Error")),
            body: const Center(child: Text("Page not found")),
          ),
        );
    }
  }
}
