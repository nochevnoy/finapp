import 'dart:convert';

import 'package:finapp/features/transactions/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];

  TransactionProvider() {
    _loadTransactions();
  }

  List<Transaction> get transactions => _transactions;

  double get totalIncome =>
      _transactions.where((tr) => tr.type == TransactionType.income).fold(0.0, (sum, tx) => sum + tx.amount);

  double get totalExpense =>
      _transactions.where((tr) => tr.type == TransactionType.expense).fold(0.0, (sum, tx) => sum + tx.amount);

  double get balance => totalIncome - totalExpense;

  void addTransaction(Transaction transaction) async {
    _transactions.add(transaction);
    notifyListeners();
    await _saveTransactions();
  }

  void removeTransaction(String id) async {
    _transactions.removeWhere((tx) => tx.id == id);
    notifyListeners();
    await _saveTransactions();
  }

  Future<void> _saveTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final String transactionsJson = jsonEncode(_transactions.map((tx) => tx.toJson()).toList());
    await prefs.setString('transactions', transactionsJson);
  }

  Future<void> _loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final String? transactionsJson = prefs.getString('transactions');
    if (transactionsJson != null) {
      final List<dynamic> transactionsList = jsonDecode(transactionsJson);
      _transactions = transactionsList.map((item) => Transaction.fromJson(item)).toList();
      notifyListeners();
    }
  }

  // Новый метод для получения данных баланса по дням
  Map<DateTime, double> getDailyBalance() {
    Map<DateTime, double> dailyBalance = {};
    double currentBalance = 0.0;

    // Сортировка транзакций по дате
    _transactions.sort((a, b) => a.date.compareTo(b.date));

    for (var transaction in _transactions) {
      currentBalance += transaction.type == TransactionType.income ? transaction.amount : -transaction.amount;
      dailyBalance[transaction.date] = currentBalance;
    }
    return dailyBalance;
  }
}
