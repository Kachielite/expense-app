import 'package:daily_expense/Widgets/expense/expense_item.dart';
import 'package:daily_expense/model/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseItems extends StatelessWidget {
  const ExpenseItems(this.expenseList,
      {super.key, required this.onDelete, required this.onEdit});

  final List<ExpenseModel> expenseList;
  final void Function(ExpenseModel)
      onDelete; // Callback function to notify parent of deletion
  final void Function(ExpenseModel)
      onEdit; // Callback function to notify parent of editing

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenseList.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenseList[index].id),
        direction:
            DismissDirection.horizontal, // Allow swiping in both directions
        background: Container(
          color: Colors.lightBlue, // Sky blue background for editing
          alignment: Alignment.centerLeft, // Align icon to the left
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
        secondaryBackground: Container(
          color: Colors.red, // Red background for deleting
          alignment: Alignment.centerRight, // Align icon to the right
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            // If swiped left (delete)
            onDelete(expenseList[index]);
          } else if (direction == DismissDirection.startToEnd) {
            // If swiped right (edit)
            onEdit(expenseList[index]);
          }
        },
        child: ExpenseItem(expenseList[index]),
      ),
    );
  }
}
