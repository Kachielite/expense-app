import 'package:daily_expense/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Widgets/chart/chart_container.dart';
import '../Widgets/expense/expense_items.dart';
import '../Widgets/expense_switch/expense_toggle_buttons.dart';
import '../enums/expense_type.dart';
import '../model/expense_model.dart';

class ExpressScreen extends ConsumerWidget {
  const ExpressScreen({
    super.key,
    required this.activeFilter,
    required this.onSelectExpenseType,
  });

  final String activeFilter;
  final void Function(String type) onSelectExpenseType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ExpenseModel> allExpenses = ref.watch(expenseProvider);
    List<ExpenseModel> incomeExpensesType = allExpenses
        .where((expense) => expense.type == ExpenseType.income)
        .toList();

    List<ExpenseModel> expenseExpenseType = allExpenses
        .where((expense) => expense.type == ExpenseType.expense)
        .toList();

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
            Expanded(child: ExpenseItems(activeFilter: activeFilter))
          ],
        ),
      ),
    );
  }
}
