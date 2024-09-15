import 'package:collection/collection.dart';
import 'package:daily_expense/Widgets/expense/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Widgets/total_expense/total_expense.dart';
import '../data/my_expenses.dart';
import '../enums/expense_type.dart';
import '../model/expense_model.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  Map<String, List<ExpenseModel>> groupExpensesByDate(
      List<ExpenseModel> expenses) {
    // Use groupBy from the collection package to group by formatted date
    return groupBy(expenses, (ExpenseModel expense) {
      // Use only the date part (ignoring time) for grouping
      return DateFormat('dd-MMM-yyyy').format(expense.createAt);
    });
  }

  @override
  Widget build(context) {
    final groupedExpenses = groupExpensesByDate(myExpenses);

    List<ExpenseModel> incomeExpensesType = myExpenses
        .where((expense) => expense.type == ExpenseType.income)
        .toList();

    List<ExpenseModel> expenseExpenseType = myExpenses
        .where((expense) => expense.type == ExpenseType.expense)
        .toList();

    double totalIncome = incomeExpensesType
        .map((expense) => expense.amount)
        .reduce((a, b) => a + b);

    double totalExpense = expenseExpenseType
        .map((expense) => expense.amount)
        .reduce((a, b) => a + b);

    final String balance = (totalIncome - totalExpense).toStringAsFixed(2);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(16, 38, 50, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(16, 38, 50, 1),
        title: const Text('Transaction History',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TotalExpense(balance),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Transactions',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
                child: ListView(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: groupedExpenses.entries.map((e) {
                    String date = e.key;
                    List<ExpenseModel> expenses = e.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(date,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ...expenses.map((expense) => ExpenseItem(expense)),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
