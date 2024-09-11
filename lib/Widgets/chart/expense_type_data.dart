import 'package:daily_expense/constants/category_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../model/expense_model.dart';

List<PieChartSectionData> getExpenseTypeSectionData(
    double screenWidth, double totalSum, List<ExpenseModel> expenses) {
  double radius = screenWidth / 4;

  double getValue(double total, double expenseAmount) {
    return ((expenseAmount / total) * 100).roundToDouble();
  }

  return expenses
      .map((expense) => PieChartSectionData(
          value: getValue(totalSum, expense.amount),
          title: '${getValue(totalSum, expense.amount)}%',
          radius: radius,
          color: categoryColors[expense.category],
          titleStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            shadows: [
              Shadow(
                // Bottom Left
                offset: Offset(-1, -1),
                color: Colors.black,
              ),
              Shadow(
                // Bottom Right
                offset: Offset(1, -1),
                color: Colors.black,
              ),
              Shadow(
                // Top Right
                offset: Offset(1, 1),
                color: Colors.black,
              ),
              Shadow(
                // Top Left
                offset: Offset(-1, 1),
                color: Colors.black,
              ),
            ],
          )))
      .toList();
}
