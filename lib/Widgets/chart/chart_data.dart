import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<PieChartSectionData> getSectionData(
    double screenWidth, totalIncome, totalExpense) {
  double radius = screenWidth / 4.8;
  // Calculate total amount and percentages
  final double total = totalIncome + totalExpense;
  final double incomePercentage = (totalIncome / total) * 100;
  final double expensePercentage = (totalExpense / total) * 100;

  return [
    PieChartSectionData(
        value: expensePercentage.roundToDouble(),
        title: '${expensePercentage.roundToDouble()}%',
        radius: radius,
        color: Colors.redAccent,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
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
        )),
    PieChartSectionData(
      value: incomePercentage.roundToDouble(),
      title: '${incomePercentage.roundToDouble()}%',
      radius: radius,
      color: Colors.greenAccent,
      titleStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
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
      ),
    ),
  ];
}
