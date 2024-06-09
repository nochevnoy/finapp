import 'package:auto_route/auto_route.dart';
import 'package:finapp/features/core/presentation/fin_app_bar.dart';
import 'package:finapp/features/core/theme/fin_colors.dart';
import 'package:finapp/features/transactions/models/transaction.dart';
import 'package:finapp/features/transactions/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class TransactionListScreen extends StatelessWidget {
  const TransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    return Scaffold(
      appBar: FinAppBar.withPreferredSize(
        context: context,
        hideActions: true,
        title: 'Список транзакций',
      ),
      body: ListView.builder(
        itemCount: transactionProvider.transactions.length,
        itemBuilder: (context, index) {
          final tr = transactionProvider.transactions[index];
          return Card(
            color: tr.type == TransactionType.income ? FinColors.green : FinColors.red,
            child: ListTile(
              title: Text(tr.title),
              subtitle: Text(tr.amount.toStringAsFixed(2)),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  transactionProvider.removeTransaction(tr.id);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
