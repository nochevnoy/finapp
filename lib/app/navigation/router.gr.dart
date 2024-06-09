// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AutoRouter extends RootStackRouter {
  // ignore: unused_element
  _$AutoRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddTransactionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddTransactionScreen(),
      );
    },
    FinAppCategoriesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FinAppCategoriesScreen(),
      );
    },
    FinAppMainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FinAppMainScreen(),
      );
    },
    TransactionListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TransactionListScreen(),
      );
    },
  };
}

/// generated route for
/// [AddTransactionScreen]
class AddTransactionRoute extends PageRouteInfo<void> {
  const AddTransactionRoute({List<PageRouteInfo>? children})
      : super(
          AddTransactionRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddTransactionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FinAppCategoriesScreen]
class FinAppCategoriesRoute extends PageRouteInfo<void> {
  const FinAppCategoriesRoute({List<PageRouteInfo>? children})
      : super(
          FinAppCategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FinAppCategoriesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FinAppMainScreen]
class FinAppMainRoute extends PageRouteInfo<void> {
  const FinAppMainRoute({List<PageRouteInfo>? children})
      : super(
          FinAppMainRoute.name,
          initialChildren: children,
        );

  static const String name = 'FinAppMainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TransactionListScreen]
class TransactionListRoute extends PageRouteInfo<void> {
  const TransactionListRoute({List<PageRouteInfo>? children})
      : super(
          TransactionListRoute.name,
          initialChildren: children,
        );

  static const String name = 'TransactionListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
