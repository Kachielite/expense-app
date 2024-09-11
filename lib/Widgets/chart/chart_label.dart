import 'package:daily_expense/Widgets/chart/chart_key.dart';
import 'package:flutter/material.dart';

class ChartLabel extends StatelessWidget {
  const ChartLabel({super.key});

  @override
  Widget build(context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChartKey(text: "Expense", color: Colors.redAccent),
        SizedBox(width: 50),
        ChartKey(text: "Income", color: Colors.greenAccent)
      ],
    );
  }
}
