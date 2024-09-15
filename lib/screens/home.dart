import 'package:daily_expense/Widgets/chart/chart_container.dart';
import 'package:daily_expense/Widgets/expense/expense_items.dart';
import 'package:daily_expense/Widgets/total_expense/total_expense.dart';
import 'package:daily_expense/data/my_expenses.dart';
import 'package:daily_expense/model/expense_model.dart';
import 'package:flutter/material.dart';

import '../enums/expense_type.dart';

class Home extends StatelessWidget {
  const Home(
      {super.key,
      required this.onAdd,
      required this.activeFilter,
      required this.onDelete,
      required this.onEdit});

  final String activeFilter;
  final void Function() onAdd;
  final void Function(ExpenseModel expense) onDelete;
  final void Function(ExpenseModel expense) onEdit;

  @override
  Widget build(context) {
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
        title: const Text('Daily Expense Tracker',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            style: IconButton.styleFrom(foregroundColor: Colors.white),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 15),
        child: Column(
          children: [
            TotalExpense(balance),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ChartContainer(
                  filter: activeFilter,
                  incomeType: incomeExpensesType,
                  expenseType: expenseExpenseType,
                  screenName: 'home'),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Transactions',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See all',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ))
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
                child: ExpenseItems(
              myExpenses,
              onDelete: onDelete,
              onEdit: onEdit,
            ))
          ],
        ),
      ),
    );
  }
}
