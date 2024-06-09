import 'package:auto_route/auto_route.dart';
import 'package:finapp/features/core/presentation/fin_app_bar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FinAppCategoriesScreen extends StatefulWidget {
  const FinAppCategoriesScreen({super.key});

  @override
  State<FinAppCategoriesScreen> createState() => _FinAppCategoriesScreenState();
}

class _FinAppCategoriesScreenState extends State<FinAppCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FinAppBar.withPreferredSize(
        context: context,
        hideActions: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'CATEGORIES',
            ),
            Text(
              'Text',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
