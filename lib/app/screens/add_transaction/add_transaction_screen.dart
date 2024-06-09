import 'package:auto_route/auto_route.dart';
import 'package:finapp/features/core/presentation/fin_app_bar.dart';
import 'package:finapp/features/transactions/models/transaction.dart';
import 'package:finapp/features/transactions/providers/transaction_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

@RoutePage()
class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  late final _titleController;
  late final _amountController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  TransactionType _type = TransactionType.income;
  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    if (_amountController.text == null) {
      // TODO ADD TOAST
    } else {
      final newTransaction = Transaction(
        id: const Uuid().v4(),
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        date: DateTime.now(),
        type: _type,
      );
      Provider.of<TransactionProvider>(context, listen: false).addTransaction(newTransaction);
      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FinAppBar.withPreferredSize(
        context: context,
        hideActions: true,
        title: 'Добавить транзакцию',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Название'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите название';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Значение'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите сумму';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Введите корректную сумму';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<TransactionType>(
                decoration: const InputDecoration(labelText: 'Тип'),
                value: _type,
                items: TransactionType.values.map(
                  (type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(describeEnum(type)),
                    );
                  },
                ).toList(),
                onChanged: (value) => setState(() {
                  _type = value!;
                }),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Дата операции: ${DateFormat.yMMMMd().format(_selectedDate)}',
                    ),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: const Text('Выбрать дату'),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text('Добавить транзакцию'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
