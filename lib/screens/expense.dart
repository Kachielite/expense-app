import 'package:flutter/material.dart';

import '../Widgets/chart/chart_container.dart';
import '../Widgets/expense/expense_items.dart';
import '../Widgets/expense_switch/expense_toggle_buttons.dart';
import '../data/my_expenses.dart';
import '../enums/expense_type.dart';
import '../model/expense_model.dart';

class ExpressScreen extends StatelessWidget {
  const ExpressScreen({
    super.key,
    required this.activeFilter,
    required this.onDelete,
    required this.onEdit,
    required this.onSelectExpenseType,
  });

  final String activeFilter;
  final void Function(ExpenseModel expense) onDelete;
  final void Function(ExpenseModel expense) onEdit;
  final void Function(String type) onSelectExpenseType;

  @override
  Widget build(context) {
    List<ExpenseModel> filteredExpense = [];
    List<ExpenseModel> incomeExpensesType = myExpenses
        .where((expense) => expense.type == ExpenseType.income)
        .toList();

    List<ExpenseModel> expenseExpenseType = myExpenses
        .where((expense) => expense.type == ExpenseType.expense)
        .toList();

    if (activeFilter == 'INCOME') {
      filteredExpense =
          myExpenses.where((e) => e.type == ExpenseType.income).toList();
    } else {
      filteredExpense =
          myExpenses.where((e) => e.type == ExpenseType.expense).toList();
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(16, 38, 50, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(16, 38, 50, 1),
        title: const Text('All Transactions',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 15),
        child: Column(
          children: [
            Expanded(
              child: ChartContainer(
                filter: activeFilter,
                incomeType: incomeExpensesType,
                expenseType: expenseExpenseType,
                screenName: 'expenses',
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ExpenseToggleButtons(onSelectExpenseType, activeFilter),
            const SizedBox(
              height: 15,
            ),
            Expanded(
                child: ExpenseItems(
              filteredExpense,
              onDelete: onDelete,
              onEdit: onEdit,
            ))
          ],
        ),
      ),
    );
  }
}
