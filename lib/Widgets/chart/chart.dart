import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../model/expense_model.dart';
import 'chart_data.dart';
import 'expense_type_data.dart';

class Chart extends StatelessWidget {
  const Chart({
    super.key,
    required this.filter,
    required this.incomeType,
    required this.expenseType,
  });

  final String filter;
  final List<ExpenseModel> incomeType;
  final List<ExpenseModel> expenseType;

  @override
  Widget build(context) {
    double totalIncome =
        incomeType.map((expense) => expense.amount).reduce((a, b) => a + b);

    double totalExpense =
        expenseType.map((expense) => expense.amount).reduce((a, b) => a + b);

    double balance = totalExpense + totalIncome;

    List<PieChartSectionData> currentSections = getSectionData(
        MediaQuery.of(context).size.width, totalIncome, totalExpense);

    if (filter == 'INCOME') {
      currentSections = getExpenseTypeSectionData(
          MediaQuery.of(context).size.width, balance, incomeType);
    }

    if (filter == 'EXPENSE') {
      currentSections = getExpenseTypeSectionData(
          MediaQuery.of(context).size.width, balance, expenseType);
    }

    return PieChart(PieChartData(
      sections: currentSections,
      centerSpaceRadius: 0,
      sectionsSpace: 0,
    ));
  }
}
