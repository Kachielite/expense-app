import 'package:daily_expense/Widgets/new_expense/new_expense.dart';
import 'package:daily_expense/model/expense_model.dart';
import 'package:flutter/material.dart';

class NewExpenseScreen extends StatelessWidget {
  const NewExpenseScreen(
      {super.key, required this.onSave, required this.onItemTapped});

  final void Function(ExpenseModel expense) onSave;
  final void Function(int index) onItemTapped;

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(16, 38, 50, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(16, 38, 50, 1),
        title: const Text('Add New Expense',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
          child: NewExpense(onSave,
              mode: "New", display: 'screen', onItemTapped: onItemTapped)),
    );
  }
}
