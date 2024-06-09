import 'package:auto_route/auto_route.dart';
import 'package:finapp/app/screens/add_transaction/add_transaction_screen.dart';
import 'package:finapp/app/screens/categories/caregories_screen.dart';
import 'package:finapp/app/screens/main/main_screen.dart';
import 'package:finapp/app/screens/transaction_list/transaction_list_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AutoRouter extends _$AutoRouter {
  @override
  List<AutoRoute> get routes => [
        //Главная
        AutoRoute(
          path: '/',
          initial: true,
          page: FinAppMainRoute.page,
        ),
        // Категории
        AutoRoute(
          path: '/categories',
          page: FinAppCategoriesRoute.page,
        ),
        // добавить транзакцию
        AutoRoute(
          path: '/add-transaction',
          page: AddTransactionRoute.page,
        ),
        // список транзакций
        AutoRoute(
          path: '/transaction-list',
          page: TransactionListRoute.page,
        ),
      ];
}
