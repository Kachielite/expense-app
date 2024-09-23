import 'package:daily_expense/Widgets/chart/chart_container.dart';
import 'package:daily_expense/Widgets/expense/expense_items.dart';
import 'package:daily_expense/Widgets/total_expense/total_expense.dart';
import 'package:daily_expense/model/expense_model.dart';
import 'package:daily_expense/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/expense_type.dart';

class Home extends ConsumerWidget {
  const Home(
      {super.key, required this.onItemTapped, required this.activeFilter});

  final String activeFilter;
  final void Function(int index) onItemTapped;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allExpenses = ref.watch(expenseProvider);
    final expenseMethods = ref.read(expenseProvider.notifier);

    List<ExpenseModel> incomeExpensesType = allExpenses
        .where((expense) => expense.type == ExpenseType.income)
        .toList();

    List<ExpenseModel> expenseExpenseType = allExpenses
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
            onPressed: () {
              expenseMethods.onAdd(context);
            },
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
                    onPressed: () {
                      onItemTapped(1);
                    },
                    child: const Text(
                      'See all',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ))
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Expanded(child: ExpenseItems())
          ],
        ),
      ),
    );
  }
}
