import 'package:daily_expense/Widgets/chart/chart_expense_label.dart';
import 'package:daily_expense/Widgets/chart/chart_label.dart';
import 'package:flutter/material.dart';

import '../../model/expense_model.dart';
import 'chart.dart';

class ChartContainer extends StatelessWidget {
  const ChartContainer(
      {super.key,
      required this.filter,
      required this.incomeType,
      required this.expenseType,
      this.screenName});

  final String filter;
  final List<ExpenseModel> incomeType;
  final List<ExpenseModel> expenseType;
  final String? screenName;

  @override
  Widget build(context) {
    Widget currentChartLabel = const ChartLabel();

    if (screenName == 'home') {
      currentChartLabel = const ChartLabel();
    } else {
      if (filter == "INCOME") {
        currentChartLabel = ChartExpenseLabel(expenseType: incomeType);
      }

      if (filter == "EXPENSE") {
        currentChartLabel = ChartExpenseLabel(expenseType: expenseType);
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 20),
      height: 243,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black),
      child: Column(
        children: [
          Expanded(
              child: Chart(
                  filter: filter,
                  incomeType: incomeType,
                  expenseType: expenseType,
                  screenName: screenName)),
          currentChartLabel
        ],
      ),
    );
  }
}
