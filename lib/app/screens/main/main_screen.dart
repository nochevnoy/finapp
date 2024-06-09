import 'package:auto_route/auto_route.dart';
import 'package:finapp/app/navigation/router.dart';
import 'package:finapp/features/core/presentation/fin_app_bar.dart';
import 'package:finapp/features/transactions/providers/transaction_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

@RoutePage()
class FinAppMainScreen extends StatefulWidget {
  const FinAppMainScreen({super.key});

  @override
  State<FinAppMainScreen> createState() => _FinAppMainScreenState();
}

class _FinAppMainScreenState extends State<FinAppMainScreen> {
  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final dailyBalance = transactionProvider.getDailyBalance();

    List<FlSpot> spots = dailyBalance.entries
        .map((entry) => FlSpot(
              entry.key.millisecondsSinceEpoch.toDouble(),
              entry.value,
            ))
        .toList();

    final hasData = dailyBalance.isNotEmpty;
    DateTime earliestDate = DateTime.now();
    DateTime latestDate = DateTime.now();

    if (hasData) {
      for (var date in dailyBalance.keys) {
        if (date.isBefore(earliestDate)) {
          earliestDate = date;
        }
        if (date.isAfter(latestDate)) {
          latestDate = date;
        }
      }
    }

    final minX = earliestDate.millisecondsSinceEpoch.toDouble();
    final maxX = latestDate.millisecondsSinceEpoch.toDouble();
    final maxY = hasData ? dailyBalance.values.reduce((a, b) => a > b ? a : b) : 0.0;

    final xInterval = (maxX - minX) / 5;
    final yInterval = maxY / 5;

    return Scaffold(
      appBar: FinAppBar.withPreferredSize(
        context: context,
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: const Text('Текущий баланс'),
              subtitle: Text(transactionProvider.balance.toStringAsFixed(2)),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Приход'),
              subtitle: Text(transactionProvider.totalIncome.toStringAsFixed(2)),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Траты'),
              subtitle: Text(transactionProvider.totalExpense.toStringAsFixed(2)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.router.push(AddTransactionRoute());
            },
            child: const Text('Добавить транзакцию'),
          ),
          ElevatedButton(
            onPressed: () {
              context.router.push(TransactionListRoute());
            },
            child: const Text('Посмотреть операции'),
          ),
          SizedBox(height: 20),
          Text('График баланса'),
          Container(
            height: 300,
            padding: EdgeInsets.all(16),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: yInterval > 0 ? yInterval : 1, // Проверка интервала по оси Y
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toStringAsFixed(2),
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: xInterval > 0 ? xInterval : 1, // Проверка интервала по оси X
                      getTitlesWidget: (value, meta) {
                        final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                        return Text(
                          DateFormat.d().format(date),
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                minX: minX,
                maxX: maxX,
                minY: 0,
                maxY: maxY,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    barWidth: 2,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
