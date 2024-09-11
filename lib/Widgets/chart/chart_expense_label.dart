import 'package:daily_expense/Widgets/chart/chart_key.dart';
import 'package:daily_expense/constants/category_colors.dart';
import 'package:daily_expense/model/expense_model.dart';
import 'package:flutter/material.dart';

class ChartExpenseLabel extends StatelessWidget {
  const ChartExpenseLabel({super.key, required this.expenseType});

  final List<ExpenseModel> expenseType;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal, // Enables horizontal scrolling
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...expenseType.map((expense) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChartKey(
                    text: expense.category.name,
                    color: categoryColors[expense.category] as Color,
                  ),
                  const SizedBox(width: 20),
                ],
              ))
        ],
      ),
    );
  }
}
