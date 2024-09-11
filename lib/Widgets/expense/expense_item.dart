import 'package:daily_expense/model/expense_model.dart';
import 'package:flutter/material.dart';

import '../../constants/category_icons.dart';
import '../../enums/expense_type.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final ExpenseModel expense;

  @override
  Widget build(context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          color: Colors.black),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                categoryIcons[expense.category],
                color: Colors.white,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                expense.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            ],
          ),
          const Spacer(),
          Text(
            expense.type == ExpenseType.income
                ? '+\$${expense.amount.toString()}'
                : '-\$${expense.amount.toString()}',
            style: TextStyle(
                color: expense.type == ExpenseType.income
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
        ],
      ),
    );
  }
}
